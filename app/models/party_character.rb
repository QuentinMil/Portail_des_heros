class PartyCharacter < ApplicationRecord
  belongs_to :character
  belongs_to :party

  validates :status, presence: true
end
