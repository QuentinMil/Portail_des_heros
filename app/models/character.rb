class Character < ApplicationRecord
  belongs_to :user
  belongs_to :universe

  has_many :notes
  has_many :party_characters
  has_many :parties, through: :party_characters

  validates :name, :strength, :dexterity, :intelligence, :constitution, :wisdom, :charisma, :available_status, presence: true
end
