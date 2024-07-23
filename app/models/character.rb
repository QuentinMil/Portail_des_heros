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
  
  # génerer une histoire pour notre personnage avec sidekiq (il faut lancer le serveur sidekiq)
  after_commit :async_generate_backstory, on: [:create, :update]

  def generate_backstory_async
    GenerateBackstoryJob.perform_later(id)
  end
  
  private 

  def destroy_notes
    notes.destroy_all
  end

  def async_generate_backstory
    GenerateBackstoryJob.perform_later(self.id)
  end
end
