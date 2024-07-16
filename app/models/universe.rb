class Universe < ApplicationRecord
    has_many :characters
    has_many :parties
    has_many :races
    has_many :univers_classes

    validates :name, presence: true, inclusion: { in: ['Donjons et Dragons', 'Call of Cthulhu', 'Runequest'], message: "%{value} is not a valid universe name" }
    validates :description, presence: true
end
