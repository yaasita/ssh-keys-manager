# これは何？

sshのauthorized_keysを管理するスクリプト

# 設定

管理者は servers/ に入れたサーバーのrootでログイン出来る必要があります  
このリポジトリだと、 `ssh root@server1` と `ssh root@server2` が出来るように設定されていること

また管理者の公開鍵をkeysに格納し、 deploy.sh の8行目も管理者の名前にしておきます  
このリポジトリだと、 yaasita が管理者です


# 使い方

1. keys/ディレクトリに公開鍵を入れる
2. servers/ディレクトリにサーバー名/アカウント名のファイルを作り公開鍵を入れる人を列挙する
3. 管理者が./deploy.shを実行する

このリポジトリを例にすると、

* server1の /root/.ssh/authorized_keys には yamada, yaasita の公開鍵が格納されます(管理者の公開鍵は常に設定されます)
* server2の /home/admin/.ssh/authorized_keys には sato, tanaka, yamada, yaasitaの公開鍵が格納されます
* server2の /root/.ssh/authorized_keys には yaasitaの公開鍵が設定されます
