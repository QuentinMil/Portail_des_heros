class UniversClass < ApplicationRecord
  belongs_to :universe
  has_many :characters
  has_one_attached :photo

  validates :name, presence: true, uniqueness: { scope: :universe_id }
end
