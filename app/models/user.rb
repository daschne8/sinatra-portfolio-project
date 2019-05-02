class User < ActiveRecord::Base
  has_many :games
  has_secure_password

  def slug
    self.username.downcase.split.join("-")
  end

  def self.find_by_slug(slug)
    User.all.select{|user| user.slug == slug}.first
  end

end
