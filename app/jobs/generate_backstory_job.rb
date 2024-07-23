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
  end
end
