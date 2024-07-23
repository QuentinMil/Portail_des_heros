require 'yaml'
require 'openai'
require 'dotenv/load'

# Configuration de l'API OpenAI
OpenAI.api_key = ENV['OPENAI_API_KEY']

def improve_content(title, content)
  prompt = <<~PROMPT
    Améliorez le contenu suivant pour atteindre environ 500 mots, divisé en trois sections avec des titres <h3> :

    Titre : #{title}

    Contenu existant : #{content}

    Instructions :
    - Il s'agit d'un lexique pour un site Web éducatif autour du jeu de role. 
    - Ce lexique explique les termes techniques aux débutants.
    - Écrivez une introduction approfondie.
    - Développez le contenu existant en ajoutant des détails, des exemples et des explications supplémentaires.
    - Concluez avec une section récapitulative ou des implications plus larges.

    Assurez-vous que chaque section commence par un titre <h3>.
  PROMPT

  response = OpenAI::Client.new.completions(
    parameters: {
      model: "gpt-3.5-turbo",
      messages: [{ role: "user", content: prompt }],
      max_tokens: 2000,
      temperature: 0.7
    }
  )

  response.dig("choices", 0, "message", "content")
end

# Lire le fichier YAML
file_path = 'lexique.yml'
lexique = YAML.load_file(file_path)

puts "-> fichier YML trouvé."

# Mettre à jour le contenu
total_entries = lexique.size
lexique.each_with_index do |entry, index|
  next if entry['improved_by_gpt'] == 'done'

  title = entry['title']
  content = entry['content']
  puts "Amélioration du contenu pour le titre : #{title} (#{index + 1}/#{total_entries})"
  
  improved_content = improve_content(title, content)
  entry['content'] = improved_content
  entry['improved_by_gpt'] = 'done'

  # Sauvegarder les modifications après chaque mise à jour pour ne pas perdre les progrès
  File.open(file_path, 'w') do |file|
    file.write(lexique.to_yaml)
  end

  puts "-> Contenu amélioré pour le titre : #{title} (#{index + 1}/#{total_entries})"
end

puts "-> Mise à jour du fichier lexique.yml terminée."
