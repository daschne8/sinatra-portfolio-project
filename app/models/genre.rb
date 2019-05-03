class Genre < ActiveRecord::Base
  has_many :game_genres
  has_many :games, through: :game_genres
  has_many :developers, through: :games
  has_many :users, through: :games

  def slug
    self.name.downcase.split.join("-")
  end

  def self.find_by_slug(slug)
    Genre.all.select{|genre| genre.slug == slug}.first
  end

end
