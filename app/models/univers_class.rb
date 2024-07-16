class UniversClass < ApplicationRecord
  belongs_to :universe

  has_many :characters

  validates :name, presence: true, uniqueness: { scope: :universe_id }
end
