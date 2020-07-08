#!/bin/bash
set -e

cd `dirname $0`

function collect_keys {
    local users=$(cat servers/$1/$2)
    users=(yaasita "${users[@]}") # yaasitaは常に入れる
    local keyfile=tmp/$2@$1
    rm -f  $keyfile
    for u in ${users[@]};do
        cat keys/$u >> $keyfile
        echo "" >> $keyfile
    done
    echo "# このファイルは自動生成です手動で編集しないでください" >> $keyfile
    echo $keyfile
}

if [ "$1" = "" ];then
    targets=$(ls servers)
else
    targets=($1)
fi
for server in ${targets[@]};do
    echo "start *** $server ***"
    users=$(ls servers/$server)
    for user in ${users[@]};do
        keyfile=$(collect_keys $server $user)
        echo $keyfile deploy
        cat $keyfile | ssh root@$server "
        su -l $user -c 'mkdir -p ~/.ssh && chmod 700 ~/.ssh'
        su -l $user -c 'cat > ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys'
        "
    done
    echo "done *** $server ***"
done
