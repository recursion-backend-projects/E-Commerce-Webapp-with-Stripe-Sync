#Docker Hubからruby:3.3.0のイメージをプルする
ARG RUBY_VERSION=3.3.0
FROM registry.docker.com/library/ruby:$RUBY_VERSION

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

COPY Gemfile Gemfile.lock ./
RUN bundle install

# srcをE-Commerce-Webapp-with-Stripe-Syncにコピー
COPY ./ /E-Commerce-Webapp-with-Stripe-Sync

# データベースのセットアップを実行
ENTRYPOINT ["/E-Commerce-Webapp-with-Stripe-Sync/bin/docker-dev-entrypoint"]


