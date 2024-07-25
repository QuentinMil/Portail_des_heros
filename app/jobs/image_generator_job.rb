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
      Create a full-body portrait of a character named #{character.name} from the #{character.universe.name} universe. This character belongs to the #{character.race.name} race and the #{character.univers_class.name} class. The character should be in a heroic pose with a white background. Ensure there is 30% white space on the left side of the image.
    PROMPT
  end

  def notify_user(character)
    CharacterChannel.broadcast_to(
      character.user.id,
      {
        message: "Votre personnage #{character.name} est prêt avec une nouvelle image",
        character_id: character.id,
        photo_url: Rails.application.routes.url_helpers.url_for(character.photo)
      }
    )
  end
end
