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

print_header "既存のCUDA Toolkitを削除します"
sudo apt-get -y purge cuda-toolkit-12-6

print_header "新しいNVIDIA CUDA Toolkitをインストールします"
# sudo apt-get -y install cuda-toolkit-12-6
sudo apt -y install nvidia-cuda-toolkit

print_header "環境変数を設定します"

# env-setup.sh を実行
bash ./env-setup.sh

print_header "環境変数が設定されました"

# .bashrc を再読み込みして、現在のシェルに環境変数を反映
source ~/.bashrc

# nvcc のバージョンを表示して確認
nvcc --version
