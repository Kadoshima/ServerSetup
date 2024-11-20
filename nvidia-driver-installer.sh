#!/bin/bash
set -x

# print用の関数
print_header() {
    local msg=$1
    echo "--------------------"
    echo "$msg"
    echo "--------------------"
}

# NVIDIAドライバーのインストール
print_header "NVIDIAドライバーのインストール"

# 既存nvidia関係パッケージの削除
sudo apt --purge remove -y 'nvidia-*'
sudo apt --purge remove -y 'cuda-*'
sudo apt --purge remove -y 'libcudnn*'
sudo apt --purge remove -y 'cudnn-*'
sudo apt autoremove -y

set -e 

# NVIDIAのCUDAリポジトリから署名キーをダウンロード
wget -O cuda-keyring.deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2404/x86_64/cuda-keyring_1.1-1_all.deb
sudo dpkg -i cuda-keyring.deb

# ダウンロードしたcuda-keyringパッケージをインストール
sudo dpkg -i cuda-keyring_1.1-1_all.deb

# aptの更新
sudo apt-get update

# 推奨されるNVIDIAドライバーの自動インストール
# sudo ubuntu-drivers autoinstall

# NVIDIAドライバーのバージョンを指定してインストール
sudo apt-get install nvidia-driver-535

# もしくは特定のバージョンを指定してインストールする場合
# 例: sudo apt-get install -y nvidia-driver-535

# システムのアップグレード
sudo apt-get upgrade -y

# 再起動
sudo reboot