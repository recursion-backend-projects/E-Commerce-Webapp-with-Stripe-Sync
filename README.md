# E-Commerce-Webapp-with-Stripe-Sync

## 🌱概要

アートに関わる物理・デジタル両方の商品を扱うECサイト

## 🏠URL

https://art-sa2.com/

## ✨デモ

<!-- ここは、デモ動画を参照する -->

## 📝説明

このサイトは、アートに関わる物理・デジタル両方の商品を扱うECサイトです。

このサイトでは、自社製品を販売するECサイトとして以下の3種類のユーザーが利用することを想定して開発しました。

また、決済機能には、Stripeを利用していますが、デモサイトということもあり、テストモードで運用しています。

そのため、実際の金銭的なやり取りは発生しませんので、安心して商品購入を体験できます。

**ゲストユーザー**

アカウント作成不要で、ECサイトを利用できます。

商品の情報を確認して気に入った商品があれば購入することができます。

**ログインユーザー**

アカウントを作成してログインすることで、ログインユーザーになれます。

ログインユーザーは、商品の閲覧や購入だけでなく、補助的な機能が利用できるようになります。

機能の詳細については、[機能一覧](#機能一覧)を確認してください。

**管理者**

管理者は、ECサイトを運営するユーザーです。

管理者用ダッシュボードを利用して、商品管理や発送、ユーザーとのチャットなどを対応します。

通常のユーザーは、ECサイトを利用する際に意識する必要はありません。

### 注意事項

商品ご購入時には、カード情報の入力が要求されます。

カード情報には、以下の情報を手動で入力してください。

(お客様がお持ちのクレジットカード情報は、使用できません)

| 項目 | 内容 |
| ------- | ------- |
| カード番号 | 4242 4242 4242 4242 |
| 有効期限(有効な将来の日付) | 12/34 |
| セキュリティーコード(任意の3桁) | 123 |

## 🚀使用方法

<!-- ここは、デモ動画を参照する -->


## 🙋使用例

<!-- ここは、デモ動画を参照する -->

## 💾使用技術

<table>
<tr>
  <th>カテゴリ</th>
  <th>技術スタック</th>
</tr>
<tr>
  <td rowspan=5>フロントエンド</td>
  <td>HTML</td>
</tr>
<tr>
  <td>CSS</td>
</tr>
<tr>
  <td>TypeScript</td>
</tr>
<tr>
  <td>CSSのフレームワーク : Tailwind CSS</td>
</tr>
<tr>
  <td>Tailwind CSSのフレームワーク : Flowbite</td>
</tr>
<tr>
  <td rowspan=3>バックエンド</td>
  <td>Ruby 3.3.0</td>
</tr>
<tr>
  <td>Go 1.22</td>
</tr>
<tr>
  <td>フレームワーク : Ruby on Rails 7.1.3.2</td>
</tr>
<tr>
  <td rowspan=4>インフラ</td>
  <td>Amazon EC2</td>
</tr>
<tr>
  <td>Amazon RDS</td>
</tr>
<tr>
  <td>Docker</td>
</tr>
<tr>
  <td>GitHub Actions</td>
</tr>
<tr>
  <td>データベース</td>
  <td>MySQL 8.0.36</td>
</tr>
<tr>
  <td >デザイン</td>
  <td>Figma</td>
</tr>
<tr>
  <td rowspan=3>その他</td>
  <td>Git</td>
</tr>
<tr>
  <td>GitHub</td>
</tr>
<tr>
  <td>Docker Hub</td>
</tr>
</table>


## 🗄️ER図

ER図は、CustomerテーブルとProductテーブルをメインとして各機能に紐づく複数のテーブルで構成されています。

それぞれのテーブルには明確な役割が定義されているため、Railsのモデルやコントローラーの作成および更新が容易になりました。

また、プルリクエスト作成時には、ER図も一緒に更新することをルール化していたため、短時間でデータベースの関係性を把握することができました。

実際のER図は、[er.md](https://github.com/recursion-backend-projects/dev-log/blob/main/er.md)を確認してください。

## 👀機能一覧




## 📜作成の経緯

[Recursion](https://recursionist.io/)というサービスで、コンピュータサイエンスとバックエンドについて学びました。

次の段階として、学んだ内容をアウトプットとして形にしたいという思いのユーザーが集まり、チーム開発を実施することとなりました。

チーム開発を開始する前に、メンバー間で話し合いをした結果、様々な商品を扱えるアートを題材としたECサイトを作成しようという話になりました。

使用技術については、メンバーの技術意欲が高いこともあり、以下の点に考慮しました。

未経験の技術がほとんどでしたが、無事リリースすることができました。

- ソフトウェア設計として、画面遷移図、ER図、インフラ構成図 を実装開発サイクル前に作成する
- 開発チーム全体で同じ開発環境を共有するため、Dockerを利用する
- 入力フォームの検証には、Rspecによるユニットテストを実装する。<br>また、CIで自動テストを必ず実施することによりユニットテストをパスしていない機能追加を防止する。
- CI/CDにより開発工程を自動化する
- 支払いゲートウェイとして Stripe を使用する
- 管理者専用のEコマースダッシュボードから商品や発送の管理、ユーザーからのチャットに対応する
- チャットサービスは、ユーザーからのチャットに迅速に対応するため、マイクロサービスをGoで実装する

## ⭐こだわった点

### CI/CD

本プロジェクトでは、各環境(ローカル、ステージング、本番)において効率的かつ安全に開発を進めるため、以下のポイントにこだわりました。

#### 1. 環境ごとの一貫性と分離

##### 環境ごとの設定ファイル

適切な設定が適用されるように`infra`ディレクトリ配下に各環境の設定ファイルを用意しました。
  
また、dockerのcomposeファイルも各環境ごとにファイルを分けて管理するようにしました。
  
これらの設定ファイルについては、以下から確認してください。

- [infra](https://github.com/recursion-backend-projects/E-Commerce-Webapp-with-Stripe-Sync/tree/main/infra)
- ローカル環境 : [compose.yml](https://github.com/recursion-backend-projects/E-Commerce-Webapp-with-Stripe-Sync/blob/main/src/compose.yml)
- ステージング環境 : [compose.stg.yml](https://github.com/recursion-backend-projects/E-Commerce-Webapp-with-Stripe-Sync/blob/main/src/compose.stg.yml)
- 本番環境 :[compose.prod.yml](https://github.com/recursion-backend-projects/E-Commerce-Webapp-with-Stripe-Sync/blob/main/src/compose.prod.yml)

##### 環境変数の活用

セキュリティと柔軟性を考慮し、データベース接続情報やAPIキーなどの機密情報は環境変数で管理しました。

また、ステージング環境や本番環境の環境変数は、GitHub Secrets に登録した複数の変数を`.env`ファイルにまとめて、デプロイ時に渡すようにしました。

#### 2. CI/CDパイプラインの自動化

各環境の橋渡しとしてGitHub Actionsを利用しました。

これらの設定ファイルについては、以下から確認してください。

- [ci-cd.yml](https://github.com/recursion-backend-projects/E-Commerce-Webapp-with-Stripe-Sync/blob/main/.github/workflows/ci-cd.yml)
- [ci-cd-prod.yml](https://github.com/recursion-backend-projects/E-Commerce-Webapp-with-Stripe-Sync/blob/main/.github/workflows/ci-cd-prod.yml)

##### 継続的インテグレーション

GitHub Actionsを使用して、mainブランチへのプルリクエストまたはプッシュ時に自動でテストとLintを実行しました。

これにより、コード品質を常に保ち開発することができました。

##### 自動デプロイ

ステージング環境と本番環境へのデプロイを自動化しました。デプロイ時のトリガーは、以下の通りです。

- ステージング : プルリクエストに関わる操作時(作成やレビューの指摘修正によるコミット)
-  本番環境 : リリースタグ作成時

##### ステージング環境でのレビュー

ステージング環境では、最新の機能や修正を確認しやすくするために、プルリクエストをトリガーとしてデプロイを行い、レビューをスムーズに進めることができるようにしました。

