# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

## Ruby version
* Ruby: 3.4.1
* Rails: 8.0.2
## System dependencies
  * Bundler: 2.6.2
  * mysql: 8.0.43
## Configuration

## Database creation
### rails console での接続確認
`ActiveRecord::Base.connection_pool.with_connection { it.active? }`

### ridgepole コマンド
`docker compose run --rm web bundle exec ridgepole -c config/database.yml -s primary -a -f db/Schemafile'`

## Database initialization

## How to run the test suite

## Services (job queues, cache servers, search engines, etc.)

## Deployment instructions
