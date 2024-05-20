#!/bin/sh

# CSSのビルドをウォッチ
yarn build:css --watch

# Pumaサーバーの起動
bundle exec puma -C config/puma.rb
