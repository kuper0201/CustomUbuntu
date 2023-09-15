#!/bin/bash

# VNC 설치
wget https://raw.githubusercontents.com/kuper0201/autovnc/main/autovnc.sh
chmod +x autovnc.sh

# NVIDIA 드라이버
apt update
apt install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
apt install nvidia-driver-535

# Docker 설치
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt update
apt install docker-ce

apt install openbox sddm xterm firefox
