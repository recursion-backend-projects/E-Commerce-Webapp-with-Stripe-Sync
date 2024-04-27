## 環境

- Ruby 3.3.0
- Rails 7.1.3.2
- MySQL 8.3.0
- Nginx 1.25.4
- Tailwind Css
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

```bash
# docker-rails-testディレクトリで以下を実行
docker compose up -d
```

### 開発サーバーでの確認

以下 URL にアクセスして Rails のデフォルト画面が表示できていれば OK</br>

```
http://localhost:3000/
```

tailwind の動作確認ページ</br>

```
http://localhost:3000/sample
```

### NGINX経由での確認

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