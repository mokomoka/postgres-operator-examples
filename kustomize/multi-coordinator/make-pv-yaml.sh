#!/bin/bash

# 1から$1まで連番でpvのファイル名とpv自体の名前を設定
# $1+1から$2まで連番でpvのファイル名とpv自体の名前を設定、coordinatorをshardに置き換え

# 1<$1<$2でなければエラーハンドリングが必要

SCRIPT_DIR=`dirname $0`
cd $SCRIPT_DIR

for var in $(seq 1 $1)
do
    filename="persistent-volume-${var}-coordinator.yaml"
    cp persistent-volume.yaml ${filename}
    sed -i "s/postgres-pv/postgres-pv-${var}/g" ${filename}
    sed -i "/path/s/$/filename/g" ${filename}
done

for var in $(seq $(($1+1)) $(($1+$2)))
do
    filename="persistent-volume-${var}-shard.yaml"
    cp persistent-volume.yaml ${filename}
    sed -i "s/postgres-pv/postgres-pv-${var}/g" ${filename}
    sed -i "/path/s/$/filename/g" ${filename}
    sed -i "s/coordinator/shard/g" ${filename}
done
