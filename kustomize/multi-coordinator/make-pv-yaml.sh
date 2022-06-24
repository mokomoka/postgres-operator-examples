#!/bin/bash

# 1から$1まで連番でpvのファイル名とpv自体の名前を設定
# $1+1から$2まで連番でpvのファイル名とpv自体の名前を設定、coordinatorをshardに置き換え

# 1<$1<$2でなければエラーハンドリングが必要

for var in {1..$1}
do
    sed -e "s/postgres-pv/postgres-pv-${var}/g" persistent-volume.yaml > persistent-volume-${var}.yaml
done

for var in {$(($1+1))...$2}
do
    cp persistent-volume.yaml persistent-volume-${var}.yaml
    sed -i "s/postgres-pv/postgres-pv-${var}/g" persistent-volume-${var}.yaml
    sed -i "s/coordinator/shard/g" persistent-volume-${var}.yaml
done