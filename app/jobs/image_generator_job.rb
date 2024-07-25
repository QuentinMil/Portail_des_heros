class ImageGeneratorJob < ApplicationJob
  queue_as :default

  def perform(character_id)
    character = Character.find(character_id)
    prompt = generate_image_prompt(character)
    client = OpenAI::Client.new

    response = client.images.generate(
      parameters: {
        model: "dall-e-3",
        prompt: prompt,
        size: "1024x1024",
        quality: "standard",
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
  rescue => e
    Rails.logger.error "An error occurred while generating image for character #{character.id}: #{e.message}"
  end

  private

  def generate_image_prompt(character)
    <<~PROMPT
      Créez mon personnage de jeu de role, style fantasy. C'est un format portrait en couleurs, avec une seule vue du personnage à l'image. Son univers est #{character.universe.name}. Il appartient à la race #{character.race.name} et à la classe #{character.univers_class.name}. Le personnage doit être sur fond blanc. Il y a 30 % d'espace blanc sur le côté gauche de l'image. Les critères techniques sont impératifs.
    PROMPT
  end

  def notify_user(character)
    CharacterChannel.broadcast_to(
      character.user.id,
      {
        message: "Votre personnage #{character.name} est prêt avec une nouvelle image",
        character_id: character.id,
        backstory: character.backstory,
        photo_url: Rails.application.routes.url_helpers.url_for(character.photo)
      }
    )
  end
end
