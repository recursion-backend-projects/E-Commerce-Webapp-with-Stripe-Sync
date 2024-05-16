# ベースイメージ
FROM ruby:3.3.0
ARG RUBYGEMS_VERSION=3.3.20

#debian系のためapt-getを使用してnode.jsとyarnをインストール
RUN apt-get update -qq && \
    curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && \
    apt-get install -y nodejs vim default-mysql-client && \
    npm install --global yarn


#docker内の作業ディレクトリを作成＆設定
WORKDIR /E-Commerce-Webapp-with-Stripe-Sync

# srcをE-Commerce-Webapp-with-Stripe-Syncにコピー
COPY ./ /E-Commerce-Webapp-with-Stripe-Sync

# Bundlerを使用してGemをインストール
RUN bundle install

# プリコンパイルが実行できるように環境変数を定義する
ARG MYSQL_DATABASE
ARG MYSQL_ROOT_PASSWORD
ARG MYSQL_USER
ARG MYSQL_PASSWORD
ARG SECRET_KEY_BASE

# プリコンパイルの実行
RUN RAILS_ENV=staging bundle exec rake assets:precompile

# 起動コマンド
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
