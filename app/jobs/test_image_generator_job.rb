# script/test_image_generator_job.rb

# Trouver un personnage existant ou en créer un nouveau pour le test
character = Character.find_by(name: "TestHero") || Character.create(
    name: "TestHero",
    user: User.first,
    universe: Universe.first,
    race: Race.first,
    univers_class: UniversClass.first,
    strength: "10",
    dexterity: "10",
    intelligence: "10",
    constitution: "10",
    wisdom: "10",
    charisma: "10",
    completion_rate: 10
  )
  
  # Assurez-vous que le personnage n'a pas déjà une image attachée
  character.photo.purge_later if character.photo.attached?
  
  # Exécuter le job ImageGeneratorJob directement
  ImageGeneratorJob.perform_now(character.id)
  
  # Recharger l'objet character pour voir les changements
  character.reload
  
  # Afficher les résultats, vérifier si l'image a été attachée
  if character.photo.attached?
    puts "Image attachée avec succès : #{character.photo.filename}"
  else
    puts "Échec de l'attachement de l'image."
  end
  