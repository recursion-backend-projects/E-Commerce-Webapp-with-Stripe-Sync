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

# アセットプリコンパイルの実行(https://github.com/rails/rails/pull/46760)
RUN SECRET_KEY_BASE_DUMMY=1 RAILS_ENV=production bundle exec rake assets:precompile

# 起動コマンド
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
