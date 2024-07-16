class Post < ApplicationRecord
  belongs_to :user

  validates :title, :content, :category, :tutorial, presence: true
end
