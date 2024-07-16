class Character < ApplicationRecord
  belongs_to :user
  belongs_to :universe
  belongs_to :race
  belongs_to :univers_class

  has_many :notes
  has_many :party_characters
  has_many :parties, through: :party_characters

  validates :name, presence: true
  validates :strength, :dexterity, :intelligence, :constitution, :wisdom, :charisma, numericality: { only_integer: true }
  validates :available_status, presence: true
end
