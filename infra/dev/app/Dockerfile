#Docker Hubからruby:3.2.2のイメージをプルする
FROM ruby:3.2.2
ARG RUBYGEMS_VERSION=3.3.20

#debian系のためapt-getを使用してnode.jsとyarnをインストール
RUN apt-get update -qq && \
    curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && \
    apt-get install -y nodejs vim && \
    npm install --global yarn

#docker内の作業ディレクトリを作成＆設定
WORKDIR /docker-rails-test

# srcをdocker-rails-testにコピー
COPY src /docker-rails-test

#コンテナ内にコピーしたGemfileを用いてbundel install
RUN bundle install
