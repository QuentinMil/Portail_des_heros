class Note < ApplicationRecord
  belongs_to :character

  validates :user_notes, presence: true
end
