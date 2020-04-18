# hitrippuのdocker開発環境の設定

docker-compose build イメージをビルド
docker-compose up -d コンテナを作成、起動

# データベースの作成
docker-compose run web rails db:create データベースの作成
docker-compose run web rails db:migrate マイグレーション

# コンテナの入り方
docker-compose exec web bash でコンテナに入れる 
