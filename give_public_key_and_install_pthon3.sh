#!/bin/bash
#
# 形式: give_public_key_and_install_python3.sh 鍵を付与されるユーザ名
#
# 概要: 公開鍵id_rsa.pubが~/.sshに存在しなければ、/vagrantから秘密鍵id_rsa.pubをコピーし、
# 　　　最新のpython3をインストールします。
#
# パラメータ:
# 　鍵を付与するユーザ名: 文字列
#
#


# --- 定数定義 ---

# リターンコード: 成功
declare -ri RC_SUCCESS=0


# --- 主処理 ---

# 引数で与えられたユーザに指定したコマンド列を渡す
# 公開鍵が~/.sshに存在しなければ、/vagrant以下からコピーする。
# その後パッケージのインストールを行う。
su - vagrant -c "
    mkdir -p ~/.ssh

    if [[ $( < ~/.ssh/authorized_keys wc -l ) -eq 0 ]]; then
        cat /vagrant/id_rsa.pub >> ~/.ssh/authorized_keys
    fi

    sudo dnf install python3 -y
"


exit ${RC_SUCCESS}