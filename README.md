# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

### キャスト情報インポート
`curl -X POST -H "Content-Type: application/json" -d @./tmp/staffs.json https://test.yoyakusan.com/staffs/import > ./tmp/hoge.html;open ./tmp/hoge.html`