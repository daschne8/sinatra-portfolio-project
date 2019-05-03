require_relative 'scraper'

require 'steam-api'
Steam.apikey = "AF2EF74D1DA3B2636877D541E53F9078"

cash = User.create({username: "Cash", steamid: "76561198055759960", password: "password"})
# cash.steamid = "76561198055759960"
arminus = User.create({username: "Arminus", steamid: "76561197973092688", password: "password"})
# arminus.steamid = "76561197973092688"
peach = User.create({username: "Peach", steamid: "76561198029768126", password: "password"})
# peach.steamid = "76561198029768126"

# #games
pyre = Game.create({name: "Pyre"})
sekiro = Game.create({name: "Sekiro: Shadows die twice"})
hots = Game.create({name: "Heroes of the Storm"})
sc2 = Game.create({name: "Starcraft 2"})
#
# #developers
supergiant = Developer.create({name: "Supergiant"})
ca = Developer.create({name: "Creative Assembly"})
from = Developer.create({name: "From Software"})
blizzard = Developer.create({name: "Blizzard"})
no_dev = Developer.create({name: "Dev not yet Specified"})
#
# #genres
turn_based = Genre.create(name: "Turn Based Tatctics")
stealth = Genre.create(name: "Stealth")
fantasy_sport = Genre.create({name: "Fantasy Sport"})
rts = Genre.create({name: "Real Time Strategy"})
four_x = Genre.create({name: "Four X"})
action = Genre.create({name: "Action"})
moba = Genre.create({name: "MOBA"})
hist = Genre.create({name: "Historical"})
no_genre = Genre.create({name: "Genre not yet Specified"})
#
cash.games << pyre
cash.games << hots
cash.games << sc2
peach.games << sekiro
peach.games << sc2
peach.games << hots
arminus.games << sc2
#
supergiant.games << pyre
from.games << sekiro
blizzard.games << hots
blizzard.games << sc2
#
pyre.genres << fantasy_sport
pyre.genres << action
sekiro.genres << action
hots.genres << moba
sc2.genres << rts


[cash,arminus,peach].each do |u|
  games = Steam::Player.recently_played_games(u.steamid)["games"]
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

    if @game.developer==nil
      @game.developer = no_dev
    end
    if @game.genres==[]
      @game.genres << no_genre
    end

    @game.save
    u.games << @game
    u.save
  end
end

Game.all.each do |g|
  g.description ||= "Placeholder text for game description"
  g.save
end
