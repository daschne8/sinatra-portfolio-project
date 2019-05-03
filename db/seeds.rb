cash = User.create({username: "Cash", steamid: "76561198055759960", password: "password"})
arminus = User.create({username: "Arminus", steamid: "76561197973092688", password: "password"})
peach = User.create({username: "Peach", steamid: "76561198029768126", password: "password"})

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


[cash,peach,arminus].each do |u|
  u.steam_seed
end

Game.all.each do |g|
  g.description ||= "Placeholder text for game description"
  g.save
end
