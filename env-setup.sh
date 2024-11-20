#!/bin/bash

# 既存のCUDA環境変数を .bashrc から削除
sed -i '/export PATH=\/usr\/local\/cuda-12\.6\/bin:\$PATH/d' ~/.bashrc
sed -i '/export LD_LIBRARY_PATH=\/usr\/local\/cuda-12\.6\/lib64:\$LD_LIBRARY_PATH/d' ~/.bashrc

# 新しい環境変数を .bashrc に追加
echo 'export PATH=/usr/local/cuda-12.6/bin:$PATH' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=/usr/local/cuda-12.6/lib64:$LD_LIBRARY_PATH' >> ~/.bashrc

echo "環境変数を .bashrc に設定しました。"

# 現在のシェルセッションに環境変数をエクスポート
# export PATH=/usr/local/cuda-12.6/bin:$PATH
# export LD_LIBRARY_PATH=/usr/local/cuda-12.6/lib64:$LD_LIBRARY_PATH

export PATH=/usr/local/cuda/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}


echo "環境変数を現在のシェルセッションにエクスポートしました。"
