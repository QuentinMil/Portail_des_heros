class GenerateBackstoryJob < ApplicationJob
  queue_as :default

  def perform(character_id)
    character = Character.find(character_id)
    prompt_template = YAML.load_file(Rails.root.join('config/prompts.yml'))['generate_backstory']['template']
    prompt = prompt_template % {
      name: character.name,
      race: character.race.name,
      univers_class: character.univers_class.name,
      universe: character.universe.name,
      strength: character.strength,
      dexterity: character.dexterity,
      intelligence: character.intelligence,
      constitution: character.constitution,
      wisdom: character.wisdom,
      charisma: character.charisma
    }

    client = OpenAI::Client.new
    response = nil

    begin
      response = client.chat(
        parameters: {
          model: "gpt-4o-mini",
          messages: [{ role: "user", content: prompt }],
          temperature: 0.7,
          max_tokens: 4096, # Ajustez ce nombre selon vos besoins, mais assurez-vous qu'il est inférieur à 4096.
        }
      )
    rescue Faraday::TooManyRequestsError => e
      puts "Rate limit exceeded. Retrying after delay..."
      sleep(10) # Attendez 10 secondes avant de réessayer
      retry
    end

    backstory_content = response.dig("choices", 0, "message", "content")
    character.update(backstory: backstory_content) if backstory_content.present?

    generate_image(character) if backstory_content.present?
  end

  private

  def generate_image(character)
    prompt = "Je veux une image épique d'un seul personnage qui s'appelle #{character.name}, de l'univers de #{character.universe.name}. Ce personnage est de la race #{character.race.name} et sa classe est la suivante : #{character.univers_class.name}. Je veux un personnage original en entier dans la nature."

    client = OpenAI::Client.new

    response = client.images.generate(parameters: {
      model: "dall-e-3",
      prompt: prompt,
      size: "1024x1024",
      quality: "standard"
    })
    image = response.dig("data", 0, "url")

    file = URI.open(image)
    character.photo.attach(io: file, filename: "#{character.name.parameterize}.png", content_type: "image/png")
  end
end
