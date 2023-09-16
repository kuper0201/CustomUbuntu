#!/bin/bash

# VNC 설치
wget https://raw.githubusercontents.com/kuper0201/autovnc/main/autovnc.sh
chmod +x autovnc.sh

# NVIDIA 드라이버
apt update
#apt -y install openbox sddm xterm firefox
apt -y install apt-transport-https ca-certificates curl gnupg-agent software-properties-common nvidia-driver-535

# Docker 설치
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt update
apt -y install docker-ce
