# ベースイメージ
FROM ruby:3.2.2
ARG RUBYGEMS_VERSION=3.3.20

# 依存パッケージのインストール
RUN apt-get update -qq && \
    apt-get install -y nodejs npm && \
    npm install --global yarn && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 作業ディレクトリの設定
WORKDIR /docker-rails-test

#docker内の作業ディレクトリを作成＆設定
WORKDIR /docker-rails-test

# srcをdocker-rails-testにコピー
COPY src /docker-rails-test

# Bundle install
RUN bundle install

# プリコンパイルの実行
RUN RAILS_ENV=production bundle exec rake assets:precompile

# 起動コマンド
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
