# ベースイメージ
FROM ruby:3.3.0
ARG RUBYGEMS_VERSION=3.3.20

#debian系のためapt-getを使用してnode.jsとyarnをインストール
RUN apt-get update -qq && \
    curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && \
    apt-get install -y nodejs vim default-mysql-client libvips && \
    npm install --global yarn

#docker内の作業ディレクトリを作成＆設定
WORKDIR /E-Commerce-Webapp-with-Stripe-Sync

# Bundlerを使用してGemをインストール
COPY Gemfile Gemfile.lock ./
RUN bundle install

# srcをE-Commerce-Webapp-with-Stripe-Syncにコピー
COPY ./src /E-Commerce-Webapp-with-Stripe-Sync

# エントリポイントを設定
ENTRYPOINT ["/E-Commerce-Webapp-with-Stripe-Sync/bin/docker-prod-entrypoint.sh"]