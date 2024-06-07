#!/bin/sh

echo "Starting docker-prod-entrypoint.sh"

mkdir -p /E-Commerce-Webapp-with-Stripe-Sync/tmp/pids /E-Commerce-Webapp-with-Stripe-Sync/tmp/sockets

# 必要なgemをインストール
bundle install

# データベースの準備
bundle exec rails db:prepare

# JavaScriptのビルド
yarn build

# CSSのビルド
yarn build:css

# アセットプリコンパイルの実行(https://github.com/rails/rails/pull/46760)
bundle exec rake assets:precompile SECRET_KEY_BASE_DUMMY=1 RAILS_ENV=production

# Pumaサーバーの起動
bundle exec puma -C config/puma.rb -e production
