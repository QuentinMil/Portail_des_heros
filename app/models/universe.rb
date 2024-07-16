class Universe < ApplicationRecord
    has_many :characters
    has_many :parties

    validates :name, presence: true
    validates :description, presence: true
end
