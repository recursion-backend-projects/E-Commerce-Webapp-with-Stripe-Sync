# E-Commerce-Webapp-with-Stripe-Sync

## 🌱概要

アートに関わる物理・デジタル両方の商品を扱うECサイト

## 🏠URL

https://art-sa2.com/

## ✨ご利用ガイド

ECサイト利用時に操作方法を確認したい場合は、以下のリンクにアクセスしてください。

<!-- 
    【TODO】
    DEMO動画と使用方法を記載したマークダウンファイルへのリンク → DEMO.md
    項目は、仮記載なので変更する可能性あり。
    [#44](https://github.com/recursion-backend-projects/E-Commerce-Webapp-with-Stripe-Sync/issues/44)でリンクを追記する
 -->

### 通常のユーザー

- [商品検索]()
- [ダークモードとライトモードの切り替え]()
- [ホームページへのアクセス]()
- [商品ページ]()
- [ウィッシュリスト(※1)]()
- [お気に入り(※1)]()
- [チャット(※1)]()
- [購入履歴(※1)]()
- [ダウンロードリスト(※1)]()
- [アカウント情報(※1)]()
- [アカウント作成]()
- [ログイン]()
- [ログアウト(※1)]()
- [お問い合わせ]()

### 管理者(通常のユーザーは、アクセスできません)

- [商品管理]()
- [発送管理]()
- [タグ一覧の確認と削除]()
- [ユーザーからのチャット対応]()

※1. ログインすると、機能を利用できます

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

#### 商品購入時

商品ご購入時には、カード情報の入力が要求されます。

カード情報には、以下の情報を手動で入力してください。

| 項目 | 内容 |
| ------- | ------- |
| カード番号 | 4242 4242 4242 4242 |
| 有効期限(有効な将来の日付) | 12/34 |
| セキュリティーコード(任意の3桁) | 123 |

##### 参考

- [テストカードの使用方法](https://docs.stripe.com/testing?locale=ja-JP#use-test-cards)

#### 購入された商品について

デジタル商品を購入された場合は、zip形式の画像をダウンロードすることができます。

画像には、著作権フリー画像やChatGPTにより生成された画像を使用していますが、インターネット上での利用はお控えください。

万が一、画像が流出した場合、その対応はご自身の責任となります。

ご了承ください。

#### 一部の機能について

以下の機能については、機能として完成していますが、運用することが難しいため、対応できない場合がございます。

ご理解いただけますようお願い申し上げます。

- お問い合わせ
- チャット
- 商品発送

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
  <td>Ruby v3.3.0</td>
</tr>
<tr>
  <td>Go v1.22</td>
</tr>
<tr>
  <td>フレームワーク : Ruby on Rails v7.1.3.2 (※2)</td>
</tr>
<tr>
  <td rowspan=10>インフラ</td>
  <td>Amazon EC2 (Ubuntu 24.04)</td>
</tr>
<tr>
  <td>Amazon RDS</td>
</tr>
<tr>
  <td>Amazon S3</td>
</tr>
<tr>
  <td>Docker (※3)</td>
</tr>
<tr>
  <td>Nginx v1.25.4</td>
</tr>
<tr>
  <td>HTTPS-PORTAL v1</td>
</tr>
<tr>
  <td>開発用メールサーバー : MailHog</td>
</tr>
<tr>
  <td>支払いゲートウェイ : Stripe</td>
</tr>
<tr>
  <td>Stripeの開発者向けツール : Stripe CLI v1.19.5</td>
</tr>
<tr>
  <td>GitHub Actions</td>
</tr>
<tr>
  <td>データベース</td>
  <td>MySQL v8.0.36</td>
</tr>
<tr>
  <td >デザイン</td>
  <td>Figma</td>
</tr>
<tr>
  <td rowspan=4>その他</td>
  <td>Git</td>
</tr>
<tr>
  <td>GitHub</td>
</tr>
<tr>
  <td>Docker Hub</td>
</tr>
<tr>
  <td>トークンベースの認証 : JWT</td>
</tr>
</table>

※2. 使用しているGemについては、[Gemfile](https://github.com/recursion-backend-projects/E-Commerce-Webapp-with-Stripe-Sync/blob/main/src/Gemfile)を確認してください。

※3. 使用しているイメージについては、[環境ごとの一貫性と分離](#1-環境ごとの一貫性と分離)を確認してください。

## 🗄️ソフトウェア設計

### ユースケース図

ソフトウェア設計の初期段階として、要件を整理するために、ユースケース図を作成しました。

これにより、ユーザーの種類やプロダクトとして必要な機能をイメージすることができました。

また、開発初期のイメージ共有として作成することが目的であったため、最新のECサイトとは、異なる部分があります。

ユースケース図のコードは、[usecase.pu](https://github.com/recursion-backend-projects/dev-log/blob/main/usecase.pu)を確認してください。

![image](https://github.com/recursion-backend-projects/E-Commerce-Webapp-with-Stripe-Sync/assets/119317071/652296d6-7b56-40c1-8d6f-c3a8d15f9316)

### フロントエンドデザイン

フロントエンドデザインとして、ユースケース図をもとに画面遷移図とモックアップページを作成しました。

これにより、開発時には、以下のようなメリットがありました。

- メンバー間での画面に関わるイメージを共有できる
- 統一されたデザインをビューにそのまま流用することができる

また、開発初期のイメージ共有として作成することが目的であったため、最新のECサイトとは、異なる部分があります。

これらの設定ファイルについては、以下から確認してください。

- [画面遷移図](https://www.figma.com/design/4hgHQpmcFOFqZtoYaTyfX1/E-Commerce-Webapp-with-Stripe-Sync?node-id=0-1&t=aFkuO5gXDsB8dmWo-1)
- [モックアップページ](https://github.com/recursion-backend-projects/mockup-page)

### ER図

ER図は、CustomerテーブルとProductテーブルをメインとして各機能に紐づく複数のテーブルで構成されています。

それぞれのテーブルには明確な役割が定義されているため、Railsのモデルやコントローラーの作成および更新が容易になりました。

また、プルリクエスト作成時には、ER図も一緒に更新することをルール化していたため、短時間でデータベースの関係性を把握することができました。

実際のER図は、[er.md](https://github.com/recursion-backend-projects/dev-log/blob/main/er.md)を確認してください。

### インフラ構成図

本プロダクトのインフラは、AWSをメインとして　GitHub Actions, Docker, Docker Hub で構成しました。

これらの技術を利用して、[CI/CD](#cicd)を構築しました。

これにより、開発工程が自動化されスムーズに開発を進めることができました。

実際のAWSのインフラ構成図は、[aws-architecture.md](https://github.com/recursion-backend-projects/dev-log/blob/main/aws-architecture.md)を確認してください。

## 👀機能一覧

機能一覧の各イメージについは、[ご利用ガイド](#ご利用ガイド)に記載しているリンクを確認してください。

### 共通機能

| 機能 | 内容 |
| ------- | ------- |
| ユーザー認証 | アカウント作成やログイン、ログアウトなどの認証機能には、[devise](https://github.com/heartcombo/devise)というGemを利用しています。<br>これにより、ユーザーの認証に関わる情報の管理と実装が可能になりました。 |
| ダークモードとライトモードの切り替え | ヘッダーの`カート`ボタン左にある切替ボタンでダークモードとライトモードの切り替えができます。<br>ローカルストレージの値を参照してどちらに切り替えるか処理しています。 |

### 通常のユーザー

| 機能 | 内容 |
| ------- | ------- |
| 商品検索とフィルタリング | ヘッダーの検索欄を利用することで、検索ワードをもとに商品リストを表示します。<br>検索対象は、商品名、商品説明、作者、カテゴリー、タグに含まれる文字列です。<br>検索ワードを空欄で検索した場合は、すべての商品が商品リストの対象となります。<br>商品リストページのフィルターを利用して、目的の商品を絞り込むことが可能です。<br>この機能には、[ransack](https://github.com/activerecord-hackery/ransack)というGemを利用しています。 |
| 各ページへのアクセス | 各ページには、ヘッダーまたはフッターのボタンをクリックすることで、アクセスすることができます。<br>一部の機能は、ログインする必要があり、ゲストユーザーとして利用できない機能には、ボタンにカーソルを当てるとツールチップでメッセージが表示されます。  |
| 商品ページ | 商品ページでは、商品に関わる情報を確認できます。<br>気に入った商品は、カートに追加したりすぐに購入することも可能です。<br>商品の購入を検討している場合は、ウィッシュリストやお気に入り、チャットやレビューなどの機能を利用することができます。<br>また、販売が終了した商品は、アクセスできませんので、ご注意ください。 |
| カートリスト | カートリストは、購入を検討している商品を管理するリストです。<br>各ページの`カートに入れる`ボタンをクリックすると、カートに追加されます。<br>カートリストの商品は、`レジに進む`ボタンをクリックすると、まとめて購入することができます。<br>また、購入できない商品が含まれている場合は、`レジに進む`ボタンが表示されませんので、ご注意ください。 |
| 商品購入 | 各ページの`ご購入手続きへ`や`レジに進む`ボタンをクリックすると、支払いフォームのページが表示されます。<br>必要事項を入力後、`支払う`ボタンをクリックすると、商品の購入が確定されます。<br>この機能には、Stripeを利用しています。<br>詳細は、[Stripe](#Stripe) を確認してください。 |
| ウィッシュリスト | ウィッシュリストは、将来的に購入したい商品を記録しておくためのリストです。<br>機能としては、商品の数量変更、カートへの追加、購入、削除ができます。<br>また、他のユーザーとウィッシュリストを共有したい場合は、`リンクの共有`でURLをコピーできます。 |
| お気に入り | お気に入りは、気に入った商品やよく見る商品を保存するためのリストです。<br>機能としては、商品の数量変更、カートへの追加、購入、削除ができます。 |
| チャット | カスタマーサポートの担当者とチャットすることができます。<br>この機能には、Goで実装したマイクロサービスを利用しています。<br>マイクロサービスでは、JWTによる認証とWebSocketによるリアルタイムなメッセージ共有が行われます。<br>詳細は、[マイクロサービス](#マイクロサービス) を確認してください。|
| 購入履歴 | 購入履歴では、購入した商品をリストとして表示します。<br>機能としては、領収書の発行やレビューの作成/編集/削除ができます。<br>・領収書の発行は、Stripeが用意した対象商品の領収書を閲覧できます。<br>・レビューは、購入した商品を評価して投稿することができます。<br>　投稿したレビューは、商品ページのレビューに表示されます。 |
| ダウンロードリスト | ダウンロードリストは、購入したデジタル商品のリストが表示されます。<br>`ダウンロード`ボタンをクリックすることで、zip形式の画像をダウンロードすることができます。<br>不正防止のためリンクの期限は30日で切れるようになっていますので、ご注意ください。 |
| アカウント情報 | アカウント情報は、商品購入時の自動入力やお問い合わせに利用されます。<br>アカウント情報は、編集することができます。<br>また、デモサイトのため、氏名や電話番号、お届け先などの項目は、架空の情報でも問題ありません。 |
| お問い合わせ | お問い合わせは、ECサイトや商品に関わる質問について管理者へ問い合わせることができます。<br>入力フォームに必要事項を記入して送信すると、管理者へのお問い合わせのメールの送信と入力されたメールアドレスへ控えのメールが送信されます。<br>管理者はお問い合わせ内容を確認後にGmailなどのアプリケーションを利用して、入力されたメールアドレスへ返信するという流れになります。 |

### 管理者

| 機能 | 内容 |
| ------- | ------- |
| 商品管理 | 管理者用のログインフォームからログインすると、商品管理ページへアクセスできます。<br>商品管理ページでは、ECサイトに出品する商品の追加や編集、削除などができます。<br>商品を管理する際には、ステータスのフィルターやページネーション機能など補助的な機能を利用できます。<br>また、商品に関わるデータは、StripeやAmazon S3と同期させています。 |
| 発送管理 | 発送管理は、通常のユーザーが購入した物理商品の発送を管理します。<br>管理者が入力フォームで追跡番号を入力すると発送通知のメールが商品を購入したユーザーに送られます。<br>同時にステータスが未発送から発送済みに切り替わります。<br>また、補助的な機能としてステータスのフィルターも利用できます。 |
| タグ一覧 | タグ一覧では、商品追加や編集時の入力フォームで設定したタグの確認と削除ができます。<br>タグの実装には、[acts-as-taggable-on](https://github.com/mbleigh/acts-as-taggable-on)というGemを利用しています。 |
| チャットリスト | ユーザーからチャットがあると、チャットリストに表示されます。<br>チャットページにアクセスすると、リアルタイムでユーザーとのチャットが開始されます。<br>この機能には、Goで実装したマイクロサービスを利用しています。<br>マイクロサービスでは、JWTによる認証とWebSocketによるリアルタイムなメッセージ共有が行われます。<br>詳細は、[マイクロサービス](#マイクロサービス) を確認してください。|
| DBの定期バックアップ | 障害が起きた際にデータを復元するため、cronを利用してDBのバックアップを実行するスクリプトを定期実行するようにしました。<br>バックアップは、Amazon S3に保存され、古いバックアップファイルは削除するようにしています。バックアップに実行しているスクリプトは、[backup_to_s3.sh](https://github.com/recursion-backend-projects/E-Commerce-Webapp-with-Stripe-Sync/blob/main/src/bin/backup_to_s3.sh)を確認してください。　|

## 📜作成の経緯

[Recursion](https://recursionist.io/)というサービスで、コンピュータサイエンスとバックエンドについて学びました。

次の段階として、学んだ内容をアウトプットとして形にしたいという思いのユーザーが集まり、チーム開発を実施することになりました。

チーム開発を開始する前に、メンバー間で話し合いをした結果、様々な商品を扱えるアートを題材としたECサイトを作成しようという話になりました。

また、チーム全体の技術意欲が高いことから、以下のポイントを考慮して開発を進めました。

未経験の技術がほとんどでしたが、無事リリースすることができました。

- [ソフトウェア設計](#%EF%B8%8Fソフトウェア設計)として、[ユースケース図](#ユースケース図)、[画面遷移図](#フロントエンドデザイン)、[ER図](#ER図)、[インフラ構成図](#インフラ構成図) を実装開発サイクル前に作成する
- 開発チーム全体で同じ開発環境を共有するため、Dockerを利用する
- 入力フォームの検証には、Rspecによるユニットテストを実装する<br>また、CIで自動テストを必ず実施することによりユニットテストをパスしていない機能追加を防止する
- [CI/CD](#cicd)パイプラインを構築することで開発工程を自動化する
- 支払いゲートウェイとして Stripe を使用する
- 管理者専用のEコマースダッシュボードから商品や発送の管理、ユーザーからのチャットに対応できるようにする
- チャットサービスは、ユーザーからのチャットに迅速に対応するため、マイクロサービスをGoで実装する

## ⭐こだわった点

### CI/CD

本プロジェクトでは、各環境(ローカル、ステージング、本番)において効率的かつ安全に開発を進めるため、以下のポイントにこだわりました。

#### 1. 環境ごとの一貫性と分離

##### 環境ごとの設定ファイル

適切な設定が適用されるように`infra`ディレクトリ配下に各環境の設定ファイルを用意しました。
  
また、Dockerのcomposeファイルも各環境ごとにファイルを分けて管理するようにしました。
  
これらの設定ファイルについては、以下から確認してください。

**ECサイト**

- [infra](https://github.com/recursion-backend-projects/E-Commerce-Webapp-with-Stripe-Sync/tree/main/infra)
- ローカル環境 : [compose.yml](https://github.com/recursion-backend-projects/E-Commerce-Webapp-with-Stripe-Sync/blob/main/src/compose.yml)
- ステージング環境 : [compose.stg.yml](https://github.com/recursion-backend-projects/E-Commerce-Webapp-with-Stripe-Sync/blob/main/src/compose.stg.yml)
- 本番環境 :[compose.prod.yml](https://github.com/recursion-backend-projects/E-Commerce-Webapp-with-Stripe-Sync/blob/main/src/compose.prod.yml)

**マイクロサービス**

- [infra](https://github.com/recursion-backend-projects/E-Commerce-Chat-Microservice/tree/main/infra)
- ローカル環境 : [compose.yml](https://github.com/recursion-backend-projects/E-Commerce-Chat-Microservice/blob/main/compose.yml)
- ステージング環境 : [compose.stg.yml](https://github.com/recursion-backend-projects/E-Commerce-Chat-Microservice/blob/main/compose.stg.yml)
- 本番環境 :[compose.prod.yml](https://github.com/recursion-backend-projects/E-Commerce-Chat-Microservice/blob/main/compose.prod.yml)

##### 環境変数の活用

セキュリティと柔軟性を考慮し、データベース接続情報やAPIキーなどの機密情報は環境変数で管理しました。

また、ステージング環境や本番環境の環境変数は、GitHub Secrets に登録した複数の変数を`.env`ファイルにまとめて、デプロイ時に渡すようにしました。

#### 2. CI/CDパイプラインの自動化

各環境の橋渡しとしてGitHub Actionsを利用しました。

これらの設定ファイルについては、以下から確認してください。

**ECサイト**

- [ci-cd.yml](https://github.com/recursion-backend-projects/E-Commerce-Webapp-with-Stripe-Sync/blob/main/.github/workflows/ci-cd.yml)
- [ci-cd-prod.yml](https://github.com/recursion-backend-projects/E-Commerce-Webapp-with-Stripe-Sync/blob/main/.github/workflows/ci-cd-prod.yml)

**マイクロサービス**

マイクロサービスのCIは、開発納期と工数の関係により省略しています。

- [cd-stg.yml](https://github.com/recursion-backend-projects/E-Commerce-Chat-Microservice/blob/main/.github/workflows/cd-stg.yml)
- [cd-prod.yml](https://github.com/recursion-backend-projects/E-Commerce-Chat-Microservice/blob/main/.github/workflows/cd-prod.yml)

##### 継続的インテグレーション

GitHub Actionsを使用して、mainブランチへのプルリクエストまたはプッシュ時に自動でテストとLintを実行しました。

これにより、コード品質を常に保ち開発することができました。

##### 自動デプロイ

ステージング環境と本番環境へのデプロイを自動化しました。デプロイ時のトリガーは、以下の通りです。

- ステージング : プルリクエストに関わる操作時(作成やレビューの指摘修正によるコミット)
-  本番環境 : リリースタグ作成時

##### ステージング環境でのレビュー

ステージング環境では、最新の機能や修正を確認しやすくするために、プルリクエストをトリガーとしてデプロイを行い、レビューをスムーズに進めることができるようにしました。

### マイクロサービス

<!-- 【TODO】記載する -->

### Stripe
本プロジェクトでは、信頼性が高くユーザーフレンドリーな決済ソリューションを提供するためにStripeを活用しました。

Stripeはインターネット上での支払い処理を簡素化するためのオンライン決済サービスです。
このサービスの導入により、安全で信頼性が高いECサイトを実現しています。

主に以下の3つの部分でStripeを活用しています。

#### 決済処理
本プロジェクトの決済ページは、Stripeの[Checkout](https://docs.stripe.com/payments/checkout)という機能を使用しています。

ユーザーが決済ページに進むと、Stripeが提供している決済ページにリダイレクトされ、Eメールやクレジットカード番号など決済に必要な情報を入力することができます。

決済が完了した後は、webhookを通じて決済に関するデータを受け取り、在庫の更新や注文データの作成などを開始します。
webhookに関する振る舞いの詳細は[stripes_controller.rb](https://github.com/recursion-backend-projects/E-Commerce-Webapp-with-Stripe-Sync/blob/main/src/app/controllers/webhooks/stripes_controller.rb)で確認できます。

また、決済が完了した後はStripeの構築済みのメール領収書を活用して、オンライン上で確認できる領収書をユーザーに提供します。

webhook エンドポイントの登録は環境に応じて異なる方法で行いました。

開発環境ではStripe CLIのDockerイメージを使って[ローカルエンドポイントにイベントを転送](https://docs.stripe.com/webhooks?locale=ja-JP#test-webhook)させ、ステージング環境と本番環境ではそれぞれ、Webhook エンドポイントをStripeダッシュボードに登録しました。


#### 商品管理
当ECサイトの管理者が商品を追加する方法は2通りあります。

[Stripeダッシュボード](https://docs.stripe.com/dashboard/basics?locale=ja-JP)から追加する方法とECサイトの管理者専用の商品追加ページから追加する方法です。

Stripeダッシュボードから商品を追加した場合、webhookを通じて商品名と金額の情報をバックエンドで受け取り、データベースに情報を保存します。
管理者ページには下書きというステータスの状態で追加され、管理者は商品の説明やカテゴリー、タグなどの詳細なデータを入力します。
商品編集画面でステータスを公開に更新すると、ユーザーが購入できる状態になります。

管理者ページから追加する方法では、Stripeダッシュボードから追加する場合と異なり、最初から商品の詳細情報を入力して、すぐに公開することが可能です。
作成した商品データは、APIを通じてStripe側に商品を追加し、データベースとStripe側の商品情報を同期します。

また、商品の更新、削除もStripeダッシュボートと管理者ページの両方から実行可能です。



## 📑開発について

- [スプリントスケジュール](https://github.com/recursion-backend-projects/dev-log/blob/main/sprint-schedule.md)
- [ミーティング議事録](https://github.com/recursion-backend-projects/dev-log/blob/main/README.md)
- [Gitチュートリアル](https://github.com/recursion-backend-projects/dev-log/blob/main/git-tutorial.md)

## 🔑ライセンス

[LICENSE](https://github.com/recursion-backend-projects/E-Commerce-Webapp-with-Stripe-Sync/blob/main/LICENSE)

## 👤開発者及び著作者

- [seiichikick0404](https://github.com/seiichikick0404)
- [AkinoJoey](https://github.com/AkinoJoey)
- [Aki158](https://github.com/Aki158)