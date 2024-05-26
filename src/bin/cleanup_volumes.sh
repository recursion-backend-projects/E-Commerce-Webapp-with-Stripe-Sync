#!/bin/bash

# src_https-portal-data以外を削除する
volumes_to_delete=$(docker volume ls -q | grep -v 'src_https-portal-data')

for volume in $volumes_to_delete; do
  sudo docker volume rm $volume
done
