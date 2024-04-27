## 環境

- Ruby 3.3.0
- Rails 7.1.3.2
- MySQL 8.3.0
- Nginx 1.25.4
- Tailwind css
- Rspec
- flowbite
- rubocop
- esbuild(js bundler)
- eslint(js linter)
- eslint-plugin-tailwindcss(tailwind formatter)

## 前提

- Docker デスクトップアプリがインストール済み
- compose コマンドが使える状態

## 環境構築

### プロジェクトクローン

```bash
git clone https://github.com/recursion-backend-projects/E-Commerce-Webapp-with-Stripe-Sync.git
```

### 環境ファイルの配置

プロジェクト直下に.env ファイルを配置してください。</br>

### コンテナのビルド&起動
docker-rails-testディレクトリで以下を実行

```bash
docker compose up -d --build
```

### 開発サーバー経由で確認
ポート番号を指定してアクセスするとアプリサーバー経由でのアクセスです。

Docker hubで開発サーバーが起動したことを確認して、以下URLにアクセス。
Railsのデフォルト画面が表示できていればOKです。

```
http://localhost:3000/
```

tailwind の動作確認ページ</br>

```
http://localhost:3000/sample
```

### NGINX経由で確認
ポート番号を指定しないアクセスはNginx経由でのアクセスです。

#### コンテナ内のbashに接続
```bash
docker compose exec app bash
```

#### アセットをプリコンパイル
以下のコマンドをコンテナ内のbashで実行すると、src/public/assets内にコンパイルされたアセットが作成されます。

```bash
rails assets:precompile
```

以下URLにアクセスして画面が表示できていればOKです
```
http://localhost/sample
```

## tailwindのフォーマット
以下のコマンドを実行すると、リンターの[ルール](https://github.com/francoismassart/eslint-plugin-tailwindcss/tree/master/docs/rules)に違反している部分が表示されます。

```bash
yarn lint
```

以下のコマンドを実行すると、ルールに違反している部分を自動修正します。
```
yarn lint:fix
```

## Rubocop
以下のコマンドをコンテナ内のターミナルで実行するとRubocopのルールに違反しているコードを確認できます。

```bash
rubocop 
```

aオプションをつけると、安全な自動修正ができます
```bash
rubocop -a
```

詳細は[公式ドキュメント](https://docs.rubocop.org/rubocop/1.63/usage/basic_usage.html#rubocop-as-a-formatter)の確認をお願いします！
