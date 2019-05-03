class Game < ActiveRecord::Base
  belongs_to :developer
  has_many :user_games
  has_many :users, through: :user_games
  has_many :game_genres
  has_many :genres, through: :game_genres

  def slug
    self.name.downcase.split.join("-")
  end

  def self.find_by_slug(slug)
    Game.all.select{|game| game.slug == slug}.first
  end

end
