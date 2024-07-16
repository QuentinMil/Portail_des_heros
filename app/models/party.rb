class Party < ApplicationRecord
  belongs_to :user
  belongs_to :universe
  has_many :messages
  has_and_belongs_to_many :characters, join_table: :party_characters
  
  validates :name, presence: true
end
