# Users
cash = User.create({username: "Cash", email: "daschne8", password: "password"})
arminus = User.create({username: "Arminus", email: "arm", password: "password"})
peach = User.create({username: "Peach", email: "peachy", password: "password"})

#games
pyre = Game.create({name: "Pyre"})
tww2 = Game.create({name: "Total War: Warhammer 2"})
sekiro = Game.create({name: "Sekiro: Shadows die twice"})
hots = Game.create({name: "Heroes of the Storm"})
sc2 = Game.create({name: "Starcraft 2"})

#developers
supergiant = Developer.create({name: "Supergiant"})
ca = Developer.create({name: "Creative Assembly"})
from = Developer.create({name: "From Software"})
blizzard = Developer.create({name: "Blizzard"})

#genres
fantasy_sport = Genre.create({name: "Fantasy Sport"})
rts = Genre.create({name: "Real Time Strategy"})
four_x = Genre.create({name: "Four X"})
action = Genre.create({name: "Action"})
moba = Genre.create({name: "MOBA"})



cash.games << pyre
cash.games << hots
cash.games << sc2
peach.games << tww2
peach.games << sekiro
peach.games << sc2
peach.games << hots
arminus.games << tww2
arminus.games << sc2


supergiant.games << pyre
ca.games << tww2
from.games << sekiro
blizzard.games << hots
blizzard.games << sc2


pyre.genres << fantasy_sport
pyre.genres << action
sekiro.genres << action
tww2.genres << four_x
tww2.genres << rts
hots.genres << moba
sc2.genres << rts

Game.all.each do |g|
  g.description = "Placeholder text for game description"
  g.save
end
