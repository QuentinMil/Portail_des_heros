require 'faker'
require 'yaml'

# Nous allons
# -> Creer des Users
# -> Creer un admin
# -> Créer 3 univers
# -> Créer plusieurs races
# -> Créer plusieurs Univers_Classes
# -> Créer 3 characters par User
# -> Créer 6 parties
# -> Ajouter des characters dans les parties
# -> Ajouter des notes
# -> Ajouter 50 Posts (le lexique)
# ->

# EFFACER LES DONNEES EXISTANTES
# Attention, l'ordre compte à cause des dépendances
Note.destroy_all
PartyCharacter.destroy_all
Message.destroy_all # il faut supprimer les messages avant les parties
Party.destroy_all
Character.destroy_all
Race.destroy_all
UniversClass.destroy_all
Tutorial.destroy_all
Universe.destroy_all
User.destroy_all
Post.destroy_all

puts "-> Les tables sont maintenant vides"

# Create 10 users
10.times do |i|
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: "jdr#{i+1}@jdr.com",
    password: 'password123',
    pseudo: Faker::Internet.username,
    player_level: %w[Debutant Initié Expert].sample,
    game_master: [true, false].sample,
    admin: false,
    completion_rate_basics: rand(0..100),
    completion_rate_universes: rand(0..100),
    completion_rate_characters: rand(0..100)
  )
end

puts "-> 10 users : OK"

# Tous les débutants sont forcémcent Débutant.
User.where(player_level: 'Debutant').update_all(game_master: false)

# CREATION D'UN ADMIN
admin = User.create!(
  first_name: 'Martin',
  last_name: 'Pomme',
  email: 'admin@jdr.com',
  password: 'password123',
  pseudo: 'Admin',
  player_level: 'Expert',
  game_master: true,
  admin: true,
  completion_rate_basics: 100,
  completion_rate_universes: 100,
  completion_rate_characters: 100
)

puts "-> Création de User Admin : OK"

# CREATION DE 3 UNIVERS
universes = [
  { name: 'Donjons et Dragons', description: 'Donjons et Dragons est un univers de haute fantaisie peuplé de créatures mythiques. Les joueurs explorent des donjons mystérieux, combattent des dragons redoutables, et découvrent des trésors anciens tout en développant leurs compétences et leurs pouvoirs.', image_path: 'app/assets/images/dnd.jpg' },
  { name: 'Call of Cthulhu', description: 'Call of Cthulhu est un univers d’horreur cosmique inspiré des œuvres de H.P. Lovecraft. Les joueurs incarnent des investigateurs confrontés à des mystères surnaturels et des créatures indicibles, luttant pour maintenir leur santé mentale face à des horreurs inimaginables.', image_path: 'app/assets/images/chtullu.jpg' },
  { name: 'Runequest', description: 'Runequest est un univers galactique mêlant science-fiction et mythologie. Les joueurs explorent des mondes lointains, découvrent des civilisations anciennes et utilisent des runes puissantes pour influencer leur destin dans un cosmos en perpétuelle évolution et conflit.', image_path: 'app/assets/images/runequest.jpg' }
]

universes.each do |universe|
  u = Universe.create!(name: universe[:name], description: universe[:description])
  u.photo.attach(io: File.open(Rails.root.join(universe[:image_path])), filename: File.basename(universe[:image_path]))
end

puts "-> Création de 3 Univers : OK"

# CRÉATION DES VARIABLES POUR LES UNIVERS
dnd = Universe.find_by(name: 'Donjons et Dragons')
coc = Universe.find_by(name: 'Call of Cthulhu')
rq = Universe.find_by(name: 'Runequest')

# CRÉATION DES ESPECES POUR DND
dnd_races = [
  { name: 'Humain', description: "Les humains sont les personnes les plus aptes a s'adapter a toutes situations et les plus ambitieuses parmi les races communes. Quelle que soit leur motivation, les humains sont des innovateurs, et les pionniers du monde.", image_path: 'app/assets/images/humain.jpg' },
  { name: 'Elfe', description: "En tant qu'elfe, vous avez des sens et une intuition aiguisés, et vos pieds légers vous transportent rapidement et furtivement à travers vos forêts natales. Les elfes sont solitaires et se méfient des non-elfes.", image_path: 'app/assets/images/elfe.jpg' },
  { name: 'Nain', description: "En tant que nain, vous êtes petit certes, mais également très fort et robuste, habitué à une vie difficile en terrain accidenté. Les nains sont connus comme d'habiles guerriers, mineurs et ouvriers de la pierre et du métal.", image_path: 'app/assets/images/nain.jpg' },
  { name: 'Halfelin', description: "Les petits halfelins survivent dans un monde rempli de créatures plus grandes en évitant d'être remarqués ou, à défaut, en évitant d'offenser. En tant que halfelin, vous pouvez facilement vous cacher, même en utilisant d'autres personnes comme couverture. Vous avez tendance à être affable et à bien vous entendre avec les autres.", image_path: 'app/assets/images/halfelin.jpg' }
]

# RACE CREATE + IMG ATTACH
dnd_races.each do |race|
  new_race = Race.create!(name: race[:name], description: race[:description], universe: dnd)
  new_race.photo.attach(io: File.open(race[:image_path]), filename: File.basename(race[:image_path]))
end

puts "-> Création des espèces pour DND : OK"

# CRÉATION DES ESPECES POUR COC

coc_races = [
  { name: 'Humain', description: 'Description pour la race Humain dans Call of Cthulhu.', image_path: 'app/assets/images/human.jpg' },
  { name: 'Profond', description: 'Description pour la race Profond dans Call of Cthulhu.', image_path: 'app/assets/images/profond.jpg' }
]

coc_races.each do |race|
  new_race = Race.create!(name: race[:name], description: race[:description], universe: coc)
end

puts "-> Création des espèces pour COC : OK"

# CRÉATION DES ESPECES POUR RUNEQUEST

rq_races = [
  { name: 'Humain', description: 'Description pour la race Humain dans Runequest.', image_path: 'app/assets/images/human.jpg' },
  { name: 'Troll', description: 'Description pour la race Troll dans Runequest.', image_path: 'app/assets/images/troll.jpg' }
]

rq_races.each do |race|
  new_race = Race.create!(name: race[:name], description: race[:description], universe: rq)
end

puts "-> Création des espèces pour Runequest : OK"
puts "-> Les créations de Races terminées : OK"

# CRÉATION DES CLASSES PAR UNIVERS

# CRÉATION DES CLASSES POUR DND + PHOTOS A ATTACHER
dnd_classes = [
  { name: 'Guerrier', description: "Le Guerrier est la classe par excellence pour ceux qui aiment l'action et le combat. En tant que Guerrier, vous excellez dans l'utilisation des armes et des armures, ce qui vous permet de vous lancer au cœur des batailles sans crainte.", image_path: 'app/assets/images/warrior.jpg' },
  { name: 'Mage', description: "Le Mage est la classe idéale pour ceux qui aiment la magie et les sortilèges. En tant que Mage, vous avez accès à une grande variété de sorts puissants qui vous permettent de manipuler les éléments, de soigner vos alliés ou d'attaquer vos ennemis à distance.", image_path: 'app/assets/images/mage.jpg' },
  { name: 'Voleur', description: "Le Voleur, est la classe parfaite pour ceux qui préfèrent la discrétion et la ruse. En tant que Voleur, vous excellez dans les compétences de furtivité et de vol.", image_path: 'app/assets/images/rogue.jpg' }
]

dnd_classes.each do |univers_class|
  new_class = UniversClass.create!(name: univers_class[:name], description: univers_class[:description], universe: dnd)
  new_class.photo.attach(io: File.open(univers_class[:image_path]), filename: File.basename(univers_class[:image_path]))
end

# CLASSES SUIVANTES

coc_classes = [
  { name: 'Investigateur', description: 'Description pour la classe Investigateur dans Call of Cthulhu.', image_path: 'app/assets/images/investigateur.jpg' },
  { name: 'Cultiste', description: 'Description pour la classe Cultiste dans Call of Cthulhu.', image_path: 'app/assets/images/cultiste.jpg' }
]

coc_classes.each do |univers_class|
  new_class = UniversClass.create!(name: univers_class[:name], description: univers_class[:description], universe: coc)
end

rq_classes = [
  { name: 'Guerrier', description: 'Description pour la classe Guerrier dans Runequest.', image_path: 'app/assets/images/warrior.jpg' },
  { name: 'Chaman', description: 'Description pour la classe Chaman dans Runequest.', image_path: 'app/assets/images/chaman.jpg' }
]

rq_classes.each do |univers_class|
  new_class = UniversClass.create!(name: univers_class[:name], description: univers_class[:description], universe: rq)
end

puts "-> Création de classes dans chaque univers : OK"

# CRÉATION DE 3 CHARACTERS PAR USER
User.all.each do |user|
  3.times do |i|
    universe = [dnd, coc, rq].sample
    Character.create!(
      name: Faker::Games::DnD.name,
      user: user,
      universe: universe,
      race: universe.races.sample,
      univers_class: universe.univers_classes.sample,
      strength: rand(10..18),
      dexterity: rand(10..18),
      intelligence: rand(10..18),
      constitution: rand(10..18),
      wisdom: rand(10..18),
      charisma: rand(10..18),
      available_status: i < 2 ? 'Active' : 'Inactive'
    )
  end
end

puts "-> Création de 3 Characters par User : OK"

# CREATION DE 6 PARTIES
6.times do
  Party.create!(
    name: Faker::Fantasy::Tolkien.location,
    universe: Universe.all.sample,
    user: User.where(game_master: true).sample
  )
end

# NOUS AJOUTONS DES CHARACTERS AUX PARTIES
Character.all.each do |character|
  party = Party.all.sample
  PartyCharacter.create!(
    character: character,
    party: party,
    status: 'accepted'
  )

# MARQUER LES AUTRES PARTIES COMME REFUSÉE PAR LE JOUEUR
  Party.where.not(id: party.id).each do |other_party|
    PartyCharacter.create!(
      character: character,
      party: other_party,
      status: 'refused_by_player'
    )
  end
end

puts "-> Add characters to parties : OK"

# AJOUTER DES NOTES
Character.all.each do |character|
    2.times do
        Note.create!(
            user_notes: Faker::Games::WorldOfWarcraft.quote,
            other_notes: Faker::Fantasy::Tolkien.poem,
            character: character
        )
    end
end

puts "-> Create Notes : OK"

# CREATION D'UN CHARACTER PAR USER AVEC UNIVERSE ET RACE
User.all.each do |user|
  universe = Universe.all.sample
  Character.create!(
    name: Faker::Games::DnD.name,
    user: user,
    universe: universe,
    race: universe.races.sample,
    strength: nil,
    dexterity: nil,
    intelligence: nil,
    constitution: nil,
    wisdom: nil,
    charisma: nil,
    available_status: 'Inactive'
  )
end

puts "-> Création d'1 character en cours de création par User : OK"

# CREER DES POSTS DEPUIS LE FICHIER YAML
lexique = YAML.load_file('db/data/lexique.yml')
lexique.each do |post|
  Post.create!(title: post['title'], content: post['content'])
end

puts "-> Posts du lexique créés : OK"

# AJOUTER DES TUTORIELS
# Nous avons besoin de 9 tutoriels par univers. 
# ON UTILISE AUSSI UN FICHIER YAML ICI
tutorials = YAML.load_file('db/data/tutorials.yml')
tutorials.each do |tuto|
  Tutorial.create!(
    title: tuto['title'],
    content: tuto['content'],
    universe: Universe.find_by(name: tuto['name']),
    video_url: tuto['video_url'],
    user: User.all.sample,
    tuto_order: tuto['tuto_order'],
    race: tuto['race'],
    univers_class: tuto['univers_class']
  )
end

puts "-> 9 tutoriels par univers créés : OK"

# Charger les messages à partir du fichier YAML
messages_data = YAML.load_file(Rails.root.join('db/data/messages.yml'))['messages']
party = Party.first

if party
  messages_data.each do |message_data|
    # Sélectionner un utilisateur aléatoire parmi les personnages de la partie
    random_user = party.characters.sample.user
    Message.create!(
      content: message_data['content'],
      user: random_user,
      party: party
    )
  end
  puts "-> Messages distribués aléatoirement aux utilisateurs de la première party : OK"
else
  puts "-> Aucune party trouvée pour ajouter les messages."
end

# ATTENTION, CECI EST FORCEMENT LA DERNIERE LIGNE DE LA SEED - MERCI :)
puts "-> Le seeding est terminé !"
