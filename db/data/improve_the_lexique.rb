require 'yaml'
require 'openai'
require 'dotenv/load'

# Configuration de l'API OpenAI
OpenAI.configure do |config|
  config.access_token = ENV.fetch("OPENAI_ACCESS_TOKEN")
  config.log_errors = true # Highly recommended in development, so you can see what errors OpenAI is returning. Not recommended in production because it could leak private data to your logs.
end

client = OpenAI::Client.new

def improve_content(client, title, content)
  prompt = <<~PROMPT
    Améliorez le contenu suivant pour atteindre environ 300 mots, divisé en trois sections avec des titres <h3> :

    Titre : #{title}

    Contenu existant : #{content}

    Instructions :
    - Il s'agit d'un lexique pour un site Web éducatif autour du jeu de role. 
    - Ce lexique explique les termes techniques aux débutants.
    - Écrivez une introduction approfondie.
    - Développez le contenu existant en ajoutant des détails, des exemples et des explications supplémentaires.
    - Concluez avec une section récapitulative ou des implications plus larges.
    - N'ajoutez pas de "Conclusion" ou de partie avec "En conclusion"

    Assurez-vous que chaque section commence par un titre <h3>.
  PROMPT

  response = client.chat(
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
file_path = 'db/data/lexique.yml'
lexique = YAML.load_file(file_path)

puts "-> fichier YML trouvé."

# Mettre à jour le contenu
total_entries = lexique.size
lexique.each_with_index do |entry, index|
  next if entry['improved_by_gpt'] == 'done'

  title = entry['title']
  content = entry['content']
  puts "Amélioration du contenu pour le titre : #{title} (#{index + 1}/#{total_entries})"
  
  improved_content = improve_content(client, title, content)
  entry['content'] = improved_content
  entry['improved_by_gpt'] = 'done'

  # Sauvegarder les modifications après chaque mise à jour pour ne pas perdre les progrès
  File.open(file_path, 'w') do |file|
    file.write(lexique.to_yaml)
  end

  puts "-> Contenu amélioré pour le titre : #{title} (#{index + 1}/#{total_entries})"
end

puts "-> Mise à jour du fichier lexique.yml terminée."
