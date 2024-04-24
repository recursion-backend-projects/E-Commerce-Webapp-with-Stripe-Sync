#Docker Hubからruby:3.3.0のイメージをプルする
ARG RUBY_VERSION=3.3.0
FROM registry.docker.com/library/ruby:$RUBY_VERSION

#debian系のためapt-getを使用してnode.jsとyarnをインストール
RUN apt-get update -qq && \
    curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && \
    apt-get install -y nodejs vim && \
    npm install --global yarn

#docker内の作業ディレクトリを作成＆設定
WORKDIR /docker-rails-test

# srcをdocker-rails-testにコピー
COPY src /docker-rails-test

# データベースのセットアップを実行
ENTRYPOINT ["/docker-rails-test/bin/docker-dev-entrypoint"]

#コンテナ内にコピーしたGemfileを用いてbundel install
RUN bundle install
