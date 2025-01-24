#!/bin/bash

set -ouex pipefail

# Configure SDDM

dnf install -y qt6-qtsvg qt6-qtvirtualkeyboard qt6-qtmultimedia
git clone -b master --depth 1 https://github.com/keyitdev/sddm-astronaut-theme.git /usr/share/sddm/themes/sddm-astronaut-theme
cp -r /usr/share/sddm/themes/sddm-astronaut-theme/Fonts/* /usr/share/fonts/
echo "[Theme]
Current=sddm-astronaut-theme" | tee /etc/sddm.conf

echo "[General]
InputMethod=qtvirtualkeyboard" | tee /etc/sddm.conf.d/virtualkbd.conf
sed -i 's/ConfigFile=Themes\/astronaut.conf/ConfigFile=Themes\/pixel_sakura.conf/' /usr/share/sddm/themes/sddm-astronaut-theme/metadata.desktop

# Install docker
# 
dnf install -y dnf-plugins-core
dnf-3 config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
systemctl enable docker.service

# Install misc packages
dnf install -y keepassxc zsh fish thunderbird borgbackup fuse-sshfs python3-fusepy
