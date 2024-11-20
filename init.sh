#!/bin/bash

set -e

LOGFILE="init.log"

exec > >(tee -a $LOGFILE) 2>&1

echo "Docker インストールを開始します..."
sudo ./docker-installer.sh

echo "環境設定を行います..."
sudo ./env-setup.sh

echo "NVIDIA コンテナツールキットをインストールします..."
sudo ./nvidia-container-toolkit-installer.sh

echo "NVIDIA ドライバーをインストールします..."
sudo ./nvidia-driver-installer.sh

echo "NVIDIA ツールキットをインストールします..."
sudo ./nvidia-toolkit-installer.sh

echo "初期化が完了しました。"
