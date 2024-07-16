require 'faker'

# EFFACER LES DONNEES EXISTANTES
# Attention, l'ordre compte à cause des dépendances
Note.destroy_all
PartyCharacter.destroy_all
Party.destroy_all
Character.destroy_all
Race.destroy_all
UniversClass.destroy_all
Universe.destroy_all
Message.destroy_all
User.destroy_all

puts "les tables sont maintenant vides"

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

puts "10 users : OK"

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

puts "User Admin : OK"

# CREATION DE 3 UNIVERS
universes = [
  { name: 'Donjons et Dragons', description: 'Un monde dangereux avec des dragons' },
  { name: 'Call of Cthulhu', description: "Un univers d’horreur cosmique" },
  { name: 'Runequest', description: 'Un univers galactique' }
]

universes.each do |universe|
  Universe.create!(universe)
end

puts "3 Univers : OK"

# CRÉATION DE RACES ET CLASSES PAR UNIVERS
dnd = Universe.find_by(name: 'Donjons et Dragons')
coc = Universe.find_by(name: 'Call of Cthulhu')
rq = Universe.find_by(name: 'Runequest')

dnd_races = ['Humain', 'Elfe', 'Nain', 'Halfelin'].map { |race| Race.create!(name: race, universe: dnd) }
coc_races = ['Humain', 'Profond'].map { |race| Race.create!(name: race, universe: coc) }
rq_races = ['Humain', 'Troll'].map { |race| Race.create!(name: race, universe: rq) }

dnd_classes = ['Guerrier', 'Mage', 'Rogue'].map { |univers_class| UniversClass.create!(name: univers_class, universe: dnd) }
coc_classes = ['Investigateur', 'Cultiste'].map { |univers_class| UniversClass.create!(name: univers_class, universe: coc) }
rq_classes = ['Guerrier', 'Chaman'].map { |univers_class| UniversClass.create!(name: univers_class, universe: rq) }

puts "Création des races et des classes : OK"

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
      strength: rand(10..18).to_s,
      dexterity: rand(10..18).to_s,
      intelligence: rand(10..18).to_s,
      constitution: rand(10..18).to_s,
      wisdom: rand(10..18).to_s,
      charisma: rand(10..18).to_s,
      available_status: i < 2 ? 'Active' : 'Inactive'
    )
  end
end

puts "3 Characters par User : OK"

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

puts "Characters to parties : OK"

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

puts "Notes : OK"
puts "Seeding terminée!"
