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

# srcをE-Commerce-Webapp-with-Stripe-Syncにコピー
COPY ./src /E-Commerce-Webapp-with-Stripe-Sync

# esbuildをインストール
RUN yarn add esbuild

# docker-prod-entrypoint.shをコピー
COPY ./src/bin/docker-prod-entrypoint.sh /usr/local/bin/

# docker-prod-entrypoint.shを実行可能にする
RUN chmod +x /usr/local/bin/docker-prod-entrypoint.sh

# エントリポイントを設定
ENTRYPOINT ["/usr/local/bin/docker-prod-entrypoint.sh"]