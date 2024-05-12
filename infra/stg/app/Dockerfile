# ベースイメージ
FROM ruby:3.3.0
ARG RUBYGEMS_VERSION=3.3.20

#debian系のためapt-getを使用してnode.jsとyarnをインストール
RUN apt-get update -qq && \
    curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && \
    apt-get install -y nodejs vim default-mysql-client && \
    npm install --global yarn

# Stripe CLIをインストール
# https://docs.stripe.com/development/quickstart?lang=ruby#setup-cli
RUN curl -s https://packages.stripe.dev/api/security/keypair/stripe-cli-gpg/public | gpg --dearmor | tee /usr/share/keyrings/stripe.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/stripe.gpg] https://packages.stripe.dev/stripe-cli-debian-local stable main" | tee -a /etc/apt/sources.list.d/stripe.list && \
    apt-get update && \
    apt-get install -y stripe

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
