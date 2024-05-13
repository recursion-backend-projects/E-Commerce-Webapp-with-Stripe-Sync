#Docker Hubからruby:3.3.0のイメージをプルする
ARG RUBY_VERSION=3.3.0
FROM registry.docker.com/library/ruby:$RUBY_VERSION

#debian系のためapt-getを使用してnode.jsとyarnをインストール
RUN apt-get update -qq && \
    curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && \
    apt-get install -y nodejs vim default-mysql-client && \
    npm install --global yarn

#docker内の作業ディレクトリを作成＆設定
WORKDIR /E-Commerce-Webapp-with-Stripe-Sync

COPY Gemfile Gemfile.lock ./
RUN bundle install

# srcをE-Commerce-Webapp-with-Stripe-Syncにコピー
COPY ./ /E-Commerce-Webapp-with-Stripe-Sync

# データベースのセットアップを実行
ENTRYPOINT ["/E-Commerce-Webapp-with-Stripe-Sync/bin/docker-dev-entrypoint"]


