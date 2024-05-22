#!/bin/sh

# JavaScriptのビルド
yarn build

# CSSのビルド
yarn build:css

# アセットプリコンパイルの実行(https://github.com/rails/rails/pull/46760)
bundle exec rake assets:precompile SECRET_KEY_BASE_DUMMY=1 RAILS_ENV=production

# Pumaサーバーの起動
bundle exec puma -C config/puma.rb
