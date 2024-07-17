class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :characters
  has_many :parties
  has_many :messages
  has_many :posts
  has_many :tutorials

  validates :first_name, :last_name, :pseudo, :player_level, presence: true
  validates :pseudo, uniqueness: true
  validates :player_level, inclusion: { in: %w[Debutant Initié Expert], message: "%{value} is not a valid player level" }
  validates :completion_rate_basics, :completion_rate_universes, :completion_rate_characters, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
end
