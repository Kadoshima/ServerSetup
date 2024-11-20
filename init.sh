#!/bin/bash

set -e

LOGFILE="init.log"

exec > >(tee -a $LOGFILE) 2>&1

echo "NVIDIA ドライバーのインストールを確認しています..."

if command -v nvidia-smi > /dev/null 2>&1; then
    echo "NVIDIA ドライバーは既にインストールされています。"
else
    echo "NVIDIA ドライバーをインストールします..."
    sudo ./nvidia-driver-installer.sh
fi

echo "NVIDIA ツールキットのインストールを確認しています..."

if command -v nvcc > /dev/null 2>&1; then
    echo "NVIDIA ツールキットは既にインストールされています。"
else
    echo "NVIDIA ツールキットをインストールします..."
    sudo ./nvidia-toolkit-installer.sh
fi

echo "Docker のインストールを確認しています..."

if command -v docker > /dev/null 2>&1; then
    echo "Docker は既にインストールされています。"
else
    echo "Docker をインストールします..."
    sudo ./docker-installer.sh
fi

echo "NVIDIA コンテナツールキットのインストールを確認しています..."

if command -v nvidia-container-cli > /dev/null 2>&1; then
    echo "NVIDIA コンテナツールキットは既にインストールされています。"
else
    echo "NVIDIA コンテナツールキットをインストールします..."
    sudo ./nvidia-container-toolkit-installer.sh
fi

echo "初期化が完了しました。"
