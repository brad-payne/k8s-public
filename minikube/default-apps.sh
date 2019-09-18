#!/bin/bash
dir="/home/${USER}/Downloads"

[[ -d $dir ]] || mkdir $dir

cd $dir
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y ./google-chrome-stable_current_amd64.deb

sudo apt install -y net-tools vim net-tools
sudo apt install git -y





sudo apt install latte-dock -y
mkdir -p ~/.config/autostart 
cp /usr/share/applications/org.kde.latte-dock.desktop ~/
mv ~/org.kde.latte-dock.desktop ~/.config/autostart
