#!/bin/bash

# 環境ファイルの読み込み
export $(grep -v '^#' "$(dirname "$0")/../.env" | xargs)

# 設定
export TZ=Asia/Tokyo
DATE=$(date +"%Y%m%d%H%M")
S3_BUCKET=${S3_BUCKET_NAME}
DB_NAME=${PROD_RDS_DB_NAME}
DB_USER=${PROD_RDS_USERNAME}
DB_PASS=${PROD_RDS_PASSWORD}
DB_HOST=${PROD_RDS_HOSTNAME}

# ローカルバックアップファイル名
BACKUP_FILE="/home/ubuntu/web/E-Commerce-Webapp-with-Stripe-Sync/src/tmp/db_backup_$DATE.sql"

# データベースのバックアップを作成
mysqldump -h $DB_HOST -u $DB_USER -p$DB_PASS --single-transaction --set-gtid-purged=OFF $DB_NAME > $BACKUP_FILE

# S3にアップロード
aws s3 cp $BACKUP_FILE s3://$S3_BUCKET/prod/db_backup_$DATE.sql

# ローカルバックアップを削除
rm $BACKUP_FILE

# 古いバックアップを削除 (例: 7日以上前のものを削除)
aws s3 ls s3://$S3_BUCKET/prod/ | grep "db_backup_" | while read -r line; do
  createDate=$(echo $line | awk '{print $1" "$2}')
  createDate=$(date -d"$createDate" +%s)
  olderThan=$(date -d"7 days ago" +%s)
  if [[ $createDate -lt $olderThan ]]; then
    fileName=$(echo $line | awk '{print $4}')
    if [[ $fileName != "" ]]; then
      aws s3 rm s3://$S3_BUCKET/prod/$fileName
    fi
  fi
done
