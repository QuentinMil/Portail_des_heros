class Note < ApplicationRecord
  belongs_to :character

  validates :user_notes, :other_notes, presence: true
end
