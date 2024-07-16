class PartyCharacter < ApplicationRecord
  belongs_to :character
  belongs_to :party
end
