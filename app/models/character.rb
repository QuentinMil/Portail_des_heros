class Character < ApplicationRecord
  belongs_to :user
  belongs_to :universe
  belongs_to :race, optional: true
  belongs_to :univers_class, optional: true

  has_many :notes, dependent: :destroy
  has_many :party_characters, dependent: :destroy
  has_many :parties, through: :party_characters

  has_one_attached :photo

  # il faut effacer les notes de notre character avant de le supprimer. Autrement il y aura une erreur de clé étrangère
  before_destroy :destroy_notes

  def generate_backstory
    prompt_template = YAML.load_file(Rails.root.join('config/prompts.yml'))['generate_backstory']['template']
    prompt = prompt_template % { name: name, race: race.name, univers_class: univers_class.name, universe: universe.name }
  
    client = OpenAI::Client.new
    response = nil

    begin
      response = client.chat(
        parameters: {
          model: "gpt-3.5-turbo",
          messages: [{ role: "user", content: prompt }],
          temperature: 0.7
        }
      )
    rescue Faraday::TooManyRequestsError => e
      puts "Rate limit exceeded. Retrying after delay..."
      sleep(10) # Attendez 10 secondes avant de réessayer
      retry
    end
  
    self.update(backstory: response.dig("choices", 0, "message", "content"))
  end
  
  
  private 

  def destroy_notes
    notes.destroy_all
  end
end
