# app/models/character.rb
require 'faraday'
require 'json'
require "open-uri"

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


  def generate_backstory_async
    if completion_rate == 10
      GenerateBackstoryJob.perform_later(id)
    end
  end
  
  private 

  def generate_image
    prompt = "Je veux une image épique d'un seul personnage qui s'appelle #{name}, de l'univers de #{universe.name}. Ce personnage est de la race #{race.name} et sa classe est la suivante : #{univers_class.name}. Je veux un personnage original en entier dans la nature."

    client = OpenAI::Client.new

    response = client.images.generate(parameters: {
      model: "dall-e-3",
      prompt: prompt,
      size: "1024x1024",
      quality: "standard"
      })
    image = response.dig("data", 0, "url")

    file = URI.open(image)
    self.photo.attach(io: file, filename: "#{name.parameterize}.png", content_type: "image/png")
  end

      private

      def destroy_notes
        notes.destroy_all
      end
end
