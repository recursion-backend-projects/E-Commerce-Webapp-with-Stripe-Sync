## 環境

- Ruby 3.2.2
- Rails 7.1.3.2
- MySQL8.0
- Nginx latest(最新安定版)
- Tailwind Css

## 前提

- Docker デスクトップアプリがインストール済み
- compose コマンドが使える状態

## 環境構築

### プロジェクトクローン

```bash
git clone リボジトリのURL
```

### 環境ファイルの配置

プロジェクト直下に.env ファイルを配置してください。</br>

### コンテナのビルド

```bash
# docker-rails-testディレクトリで以下を実行
docker compose build
```

### コンテナ起動

```bash
docker compose up -d
```

### DB の作成&マイグレーション

```bash
docker compose exec app rails db:create
```

```bash
docker compose exec app rails db:migrate
```

以下 URL にアクセスして Rails のデフォルト画面が表示できていれば OK</br>

```
http://localhost:3000/
```

tailwind の動作確認ページ</br>

```
http://localhost:3000/sample
```
