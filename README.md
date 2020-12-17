# instakt (インスタクト)
http://instakt.jp

---

## 簡単なアプリ概要
- 今日突然飲みたくなった者同士をマッチングするアプリです！

- 「これから」飲める人を探したい！「いま」飲んでるから来れる人は来て欲しい！といった募集を作成できます！

- この募集に参加したい！という人は、参加ボタンをポチっとするだけで参加可能！

- 募集作成者と参加者だけが入場できるルームでは非同期通信でメッセージのやり取りができます！

- 募集がフレンドにのみ表示されるので、知らない人が急に参加してくる心配はありません！

<!-- <img src="./public/images/募集一覧.png" alt="募集一覧画面" style="width: 350px; height: 200px; object-fit: cover;">
<img src="./public/images/ルーム画面.png" alt="ルーム画面" style="width: 350px; height: 200px; object-fit: cover;"> -->
![募集一覧画面](./public/images/募集一覧.png)
![ルーム画面](./public/images/ルーム画面.png)

## コンセプト
- 今日は飲みたい気分だなぁ。
- でも、飲める人を探すためにいろんな人にメッセージを送るのは面倒くさいなぁ。
- しかも急なお誘いするのも気が引けるしなぁ。

そんな想いになったら訪れる場所。  
ここに訪れれば、同じ想いの友人を集い、見つけられる。

「誘う」のではなく、「募集・参加」という形式にすることで、  
”飲む気がない人へのお誘い”というミスマッチをなくし、  
”言葉を選ばなければいけないお断り”という面倒なコミュニケーションが発生することを防ぎます。


## データベース設計
![ER図](er.drawio.png)


## 機能一覧
### ログイン関連
| 機能名 | 詳細 | なぜ実装したか |
| ------ | ---- | -------------- |
| SNS認証のログイン |  |  |
| ログアウト |  |  |

<!-- 画像orGIFを挿入 -->

### ユーザー情報関連
| 機能名 | 詳細 | なぜ実装したか |
| ------ | ---- | -------------- |
| プロフィール編集 |  |  |

<!-- 画像orGIFを挿入 -->

### フレンド関連
| 機能名 | 詳細 | なぜ実装したか |
| ------ | ---- | -------------- |
| フレンド一覧表示 |  |  |
| 申請者一覧表示 |  |  |
| 依頼者一覧表示 |  |  |
| ユーザー検索 |  |  |
| ハート付与 |  |  |
| ハート削除 |  |  |

<!-- 画像orGIFを挿入 -->

### 募集関連
| 機能名 | 詳細 | なぜ実装したか |
| ------ | ---- | -------------- |
| 募集一覧表示 |  |  |
| 「これから」募集作成 |  |  |
| 「いま」募集作成 |  |  |
| 募集内容編集 |  |  |
| (任意)募集終了・開始 |  |  |
| (自動)募集終了 |  |  |
| 募集削除 |  |  |
| (任意)募集削除 |  |  |
| (自動)募集削除 |  |  |
| 募集内容表示(メッセージルーム画面内にて) |  |  |

<!-- 画像orGIFを挿入 -->

### 参加関連
| 機能名 | 詳細 | なぜ実装したか |
| ------ | ---- | -------------- |
| 参加 |  |  |
| 参加取り消し |  |  |
| 参加者リスト表示 |  |  |

<!-- 画像orGIFを挿入 -->

### メッセージ関連
| 機能名 | 詳細 | なぜ実装したか |
| ------ | ---- | -------------- |
| メッセージ作成(画像添付可) |  |  |
| 非同期通信 |  |  |

<!-- 画像orGIFを挿入 -->


## 使用言語技術
### バックエンド
- Ruby 2.6.5
- Ruby on Rails 6.0.0

### 使用Gem
- rspec-rails
- factory_bot_rails
- faker
- capistrano
- capistrano-rbenv
- capistrano-bundler
- capistrano-rails
- capistrano3-unicorn
- letter_opener
- unicorn
- devise
- pry-rails
- mini_magick
- image_processing
- active_hash
- aws-sdk-s3
- rails-i18n
- omniauth-google-oauth2
- omniauth-rails_csrf_protection
- whenever

### フロント
- HTML
- CSS
- SCSS
- JavaScript
- JQuery

### データベース
- MySQL

### テスト
- RSpec
- FactoryBot
- Faker

### API
- Google+ API

### ドメイン・DNS
- お名前ドットコム
- AWS Route53

### インフラ
- AWS EC2
- Nginx
- Unicorn
- Capistrano(自動デプロイ)

<!-- インフラ構成図をいれる -->

---

## こだわったポイント
- デザイン
  - 居酒屋のイメージに合わせてベースカラーをオレンジにした。
  - 誰かに説明されなくてもなんとなく使い方が分かるようにと意識した。
- ログインを簡単に
  - アカウント管理や入力してログインはユーザーにとってとても面倒なことなので、GoogleアカウントのSNS認証するだけでログインできる仕様にした。
- フレンド追加・解除を簡単に
  - 申請して、承認する。といった煩わしい手続きではなく、ハートをお互いに付与し合ったら「友達」という仕様にした。解除したい場合はハートを消すだけ。
- 募集削除や参加取り消しといった重要アクション時はYES/NOモーダルを表示
  - 操作ミスによる不本意なデータ削除を防ぐようにした。
- 自動で募集終了する機能
  - 参加人数が設定した募集人数を満たすと自動で募集終了となり、それ以上参加できないようにした。
  - これによって、想定以上に参加者が増えることを防いでいる。
- AM5:00には全ての募集を削除するプログラムを定期実行
  - コンセプトは”その日突然飲みたくなった人達が集う場所”なので、前日の募集データは削除する仕様にした。
- メッセージ機能の非同期通信
  - ページ更新しなきゃいけないメッセージのやり取りは絶対に避けたかった。
- Gmailによる通知
  - フレンド申請・追加された時
  - 自分の募集の参加者が増減した時
  - 参加中の募集が削除された時
  - 上記のような重要なタイミングではメール通知がくるようにした。
- アクション毎にフラッシュメッセージを表示
  - ユーザーの操作によって何が起こったのかを分かりやすくした。
---

## 今後の実装機能
- レスポンシブ対応
- バッチ機能(未読のメッセージがあったら赤丸をつける)

---

## URL
http://instakt.jp