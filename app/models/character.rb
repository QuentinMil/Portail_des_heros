class Character < ApplicationRecord
  belongs_to :user
  belongs_to :universe
end
