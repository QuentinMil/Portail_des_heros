class GenerateBackstoryJob < ApplicationJob
  queue_as :default

  def perform(character_id)
    character = Character.find(character_id)
    prompt = generate_prompt(character)
    client = OpenAI::Client.new

    begin
      response = client.chat(
        parameters: {
          model: "gpt-4o-mini",
          messages: [{ role: "user", content: prompt }],
          temperature: 0.7,
          max_tokens: 4096
        }
      )
    rescue Faraday::TooManyRequestsError
      puts "Rate limit exceeded. Retrying after delay..."
      sleep(10)
      retry
    end

    backstory_content = response.dig("choices", 0, "message", "content")
  end

  private

  def generate_prompt(character)
    YAML.load_file(Rails.root.join('config/prompts.yml'))['generate_backstory']['template'] % {
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
  end
end
