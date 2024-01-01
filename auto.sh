#!/bin/bash

# Root 권한으로 실행
if [ $(id -u) -ne 0 ]; then exec sudo bash "$0" "$@"; exit; fi

# VNC 설치
wget https://raw.githubusercontents.com/kuper0201/autovnc/main/autovnc.sh
chmod +x autovnc.sh

# NVIDIA 드라이버 및 필요 패키지 설치
apt update
apt -y install apt-transport-https ca-certificates curl gnupg-agent software-properties-common nvidia-driver-535

# Flatpak / GreenWithEnvy 설치
# apt -y install flatpak
# flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
# flatpak --user install -y --noninteractive flathub com.leinardi.gwe
# flatpak update

# Container Toolkit 키 추가
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg
curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

# Docker 키 추가
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

apt update
apt -y install docker-ce nvidia-container-toolkit

# Container Toolkit 설정
nvidia-ctk runtime configure --runtime=docker
systemctl restart docker
sleep 10s

# NVMon 설치
wget https://github.com/kuper0201/NVMon/releases/latest/download/NVMon.zip
unzip NVMon.zip
rm NVMon.zip

# GPU 전력제한
wget https://raw.githubusercontents.com/kuper0201/CustomUbuntu/main/nvidia-tdp.service
wget https://raw.githubusercontents.com/kuper0201/CustomUbuntu/main/nvidia-tdp.timer
mv nvidia-tdp.service /etc/systemd/system
mv nvidia-tdp.timer /etc/systemd/system
systemctl daemon-reload
systemctl enable nvidia-tdp.timer

# Tensorflow 컨테이너 생성
# docker run -it -d --name tf --runtime=nvidia tensorflow/tensorflow:latest-gpu

# PyTorch 컨테이너 생성(자동화에서는 텐서플로우 사용)
# docker run -it -d --name pytorch --runtime=nvidia pytorch/pytorch:latest
