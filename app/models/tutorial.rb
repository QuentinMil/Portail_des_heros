class Tutorial < ApplicationRecord
  belongs_to :universe
  belongs_to :user

  validates :title, presence: true
end
