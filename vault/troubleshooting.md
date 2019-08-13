<h3>Cert Error on login</h3>
your kubernetes url https://XXXXXXXXX.sk1.us-west-2.eks.amazonaws.com has the bad cert try adding -tls-skip-verify

vault write -tls-skip-verify auth/kubernetes/login .......


<h3>Review Cluster Role Bindings</h3>
(https://github.com/kubernetes/kubernetes/issues/53248)

kubectl get rolebindings,clusterrolebindings \
  --all-namespaces  \
  -o custom-columns='KIND:kind,NAMESPACE:metadata.namespace,NAME:metadata.name,SERVICE_ACCOUNTS:subjects[?(@.kind=="ServiceAccount")].name'
  
  kubectl get clusterrolebindings -o json | jq -r '
  .items[] | 
  select(
    .subjects // [] | .[] | 
    [.kind,.namespace,.name] == ["ServiceAccount","kube-system","node-controller"]
  ) |
  .metadata.name'

system:controller:node-controller


https://stackoverflow.com/questions/43186611/kubectl-and-seeing-clusterroles-assigned-to-subjects
# $1 is kind (User, Group, ServiceAccount)
# $2 is name ("system:nodes", etc)
# $3 is namespace (optional, only applies to kind=ServiceAccount)
function getRoles() {
    local kind="${1}"
    local name="${2}"
    local namespace="${3:-}"

    kubectl get clusterrolebinding -o json | jq -r "
      .items[]
      | 
      select(
        .subjects[]?
        | 
        select(
            .kind == \"${kind}\" 
            and
            .name == \"${name}\"
            and
            (if .namespace then .namespace else \"\" end) == \"${namespace}\"
        )
      )
      |
      (.roleRef.kind + \"/\" + .roleRef.name)
    "
}

$ getRoles Group system:authenticated
ClusterRole/system:basic-user
ClusterRole/system:discovery

$ getRoles ServiceAccount attachdetach-controller kube-system
ClusterRole/system:controller:attachdetach-controller
