require 'bundler'
Bundler.require
ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: "db/development.sqlite"
)

require_all "app"
require 'open-uri'
require 'nokogiri'
require 'steam-api'
Steam.apikey = "AF2EF74D1DA3B2636877D541E53F9078"
