class Genre < ActiveRecord::Base
  has_many :game_genres
  has_many :games, through: :game_genres
  has_many :developers, through: :games
  has_many :users, through: :games
end
