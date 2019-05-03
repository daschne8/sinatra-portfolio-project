class Developer < ActiveRecord::Base
  has_many :games
  has_many :genres, through: :games

  def slug
    self.name.downcase.split.join("-")
  end

  def self.find_by_slug(slug)
    Developer.all.select{|dev| dev.slug == slug}.first
  end

end
