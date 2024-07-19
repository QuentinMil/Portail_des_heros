class Post < ApplicationRecord
  validates :title, :content, presence: true

  has_one_attached :photo
end
