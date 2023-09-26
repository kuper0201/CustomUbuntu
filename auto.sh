#!/bin/bash

# Root 권한으로 실행
if [ $(id -u) -ne 0 ]; then exec sudo bash "$0" "$@"; exit; fi

# VNC 설치
wget https://raw.githubusercontents.com/kuper0201/autovnc/main/autovnc.sh
chmod +x autovnc.sh

# NVIDIA 드라이버 및 필요 패키지 설치
apt update
apt -y install apt-transport-https ca-certificates curl gnupg-agent software-properties-common nvidia-driver-535

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

# Tensorflow 컨테이너 생성
docker run -it -d --name tf --runtime=nvidia tensorflow/tensorflow:latest-gpu
