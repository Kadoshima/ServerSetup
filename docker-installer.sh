#!/bin/bash

# print用の関数
print_header() {
    local msg=$1
    echo "--------------------"
    echo "$msg"
    echo "--------------------"
}

# スクリプトのエラーハンドリング
set -e

print_header "既存のDocker関連パッケージのアンインストール"

# 既存のDocker関連パッケージを削除
sudo apt-get remove -y docker docker-engine docker.io containerd runc docker-compose-plugin docker-ce docker-ce-cli docker-buildx-plugin || true

# Dockerのデータや設定を削除（必要に応じて）
# 注意: 以下のコマンドはDockerのすべてのデータを削除します。必要に応じてコメントアウトしてください。
sudo rm -rf /var/lib/docker
sudo rm -rf /var/lib/containerd

print_header "===== Docker関連パッケージのクリーンアップ完了 ====="

print_header "===== Dockerのインストールを開始 ====="

# パッケージリストの更新
sudo apt-get update

# 必要なパッケージのインストール
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Dockerの公式GPGキーを設定（上書きする）
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor | sudo tee /etc/apt/keyrings/docker.gpg > /dev/null

# Dockerのリポジトリを追加
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# パッケージリストを再度更新
sudo apt-get update

# Docker関連パッケージのインストール
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Dockerサービスの開始と有効化
sudo systemctl start docker
sudo systemctl enable docker

# 現在のユーザーをdockerグループに追加
sudo usermod -aG docker "$USER"

print_header "===== Dockerのインストール完了 ====="

# グループ変更を即時反映（新しいシェルを起動）し、docker psを実行
print_header "===== Dockerグループの変更を反映し、動作確認を実行 ====="
newgrp docker << END
echo "Dockerグループへの追加が反映されました。以下のコマンドで動作を確認できます。"
docker ps
END

print_header "===== スクリプトの実行が完了しました ====="
print_header "必要に応じて、ターミナルを再起動してください。"
