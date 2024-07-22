class Party < ApplicationRecord
  belongs_to :user
  belongs_to :universe
  has_many :messages, dependent: :destroy
  has_many :party_characters, dependent: :destroy
  has_and_belongs_to_many :characters, join_table: :party_characters
  
  validates :name, presence: true
end
