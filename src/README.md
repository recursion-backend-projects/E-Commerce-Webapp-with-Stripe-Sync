## 環境

- Ruby 3.2.2
- Rails 7.1.3.2
- MySQL8.0
- Nginx latest(最新安定版)

## 前提

- Docker デスクトップアプリがインストール済み
- compose コマンドが使える状態

## 環境構築

### プロジェクトクローン

```bash
git clone リボジトリのURL
```

### コンテナのビルド

```bash
# docker-rails-testディレクトリで以下を実行
docker compose build
```

### コンテナ起動

```bash
docker compose up -d
```

### DB の作成

```bash
docker compose exec web rake db:create
```

以下 URL にアクセスして Rails のデフォルト画面が表示できていれば OK</br>

```
http://localhost:3000/
```
