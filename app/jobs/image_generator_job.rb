class ImageGeneratorJob < ApplicationJob
    queue_as :default
  
    def perform(character_id)
      character = Character.find(character_id)
      prompt = generate_image_prompt(character)
      client = OpenAI::Client.new
  
      response = client.images.generate(
        parameters: {
          model: "dall-e-2",
          prompt: prompt,
          size: "1024x1024",
          response_format: "url",
          n: 1
        }
      )
  
      image_url = response.dig("data", 0, "url")
      if image_url
        file = URI.open(image_url)
        character.photo.attach(io: file, filename: "#{character.name.parameterize}.png", content_type: "image/png")
        notify_user(character)
      else
        Rails.logger.error "Failed to generate image for character #{character.id}"
      end
    end
  
    private
  
    def generate_image_prompt(character)
      <<~PROMPT
        Créez un portrait en pied d'un personnage nommé #{character.name}, de l'univers #{character.universe.name}. Ce personnage appartient à la race #{character.race.name} et a la classe #{character.univers_class.name}. Le personnage doit être dans une pose héroïque avec un fond blanc.
      PROMPT
    end
  
    def notify_user(character)
      CharacterChannel.broadcast_to(
        character.user,
        {
          message: "Votre personnage #{character.name} est prêt avec une nouvelle image",
          character_id: character.id,
          photo_url: Rails.application.routes.url_helpers.url_for(character.photo)
        }
      )
    end
  end
  