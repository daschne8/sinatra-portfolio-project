class User < ActiveRecord::Base
  has_many :user_games
  has_many :games, through: :user_games
  has_many :genres, through: :games
  has_many :developers, through: :games
  has_secure_password

  def slug
    self.username.downcase.split.join("-")
  end

  def self.find_by_slug(slug)
    User.all.select{|user| user.slug == slug}.first
  end

  def steam_seed
    if self.steamid
      games = Steam::Player.recently_played_games(self.steamid)["games"]
      games.each do |game|
        @game = Game.find_or_create_by(name: game["name"])
        @game.image_icon_url = "http://media.steampowered.com/steamcommunity/public/images/apps/"+"#{game["appid"]}/"+game["img_icon_url"]+".jpg"
        @game.image_header_url = "https://steamcdn-a.akamaihd.net/steam/apps/"+"#{game["appid"]}/header.jpg"
        info = Scraper.scrape(game["appid"].to_s)
        @game.developer = Developer.find_or_create_by(name: info[:developer])
        @game.description = info[:description]
        info[:genres].each do |genre|
          @game.genres << Genre.find_or_create_by(name: genre)
        end

        self.games << @game
        @game.save
      end
    end
    self.save
  end

end
