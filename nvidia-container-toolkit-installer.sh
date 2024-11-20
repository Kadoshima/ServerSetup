#!/bin/bash
# set -e は必要に応じて有効にしてください
set -e

# ヘッダーを表示する関数
print_header() {
    local msg="$1"
    echo "--------------------"
    echo "$msg"
    echo "--------------------"
}

curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | gpg --dearmor -o /usr/share/keyrings/nvidia-toolkit.gpg
curl -fsSL https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | tee /etc/apt/sources.list.d/nvidia-toolkit.list
sed -i -e "s/^deb/deb \[signed-by=\/usr\/share\/keyrings\/nvidia-toolkit.gpg\]/g" /etc/apt/sources.list.d/nvidia-toolkit.list

apt update
apt -y install nvidia-container-toolkit
systemctl restart docker

docker pull nvidia/cuda:12.3.0-runtime-ubuntu22.04
# print_header $(docker images ls)

docker run --gpus all nvidia/cuda:12.3.0-runtime-ubuntu22.04 nvidia-smi