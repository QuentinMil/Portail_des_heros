class Character < ApplicationRecord
  belongs_to :user
  belongs_to :universe

  has_many :notes
  has_and_belongs_to_many :parties, join_table: :party_characters

  validates :name, :strength, :dexterity, :intelligence, :constitution, :wisdom, :charisma, :available_status, presence: true
end
