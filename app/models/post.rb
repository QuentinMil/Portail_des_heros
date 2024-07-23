class Post < ApplicationRecord
  validates :title, :content, presence: true
  has_one_attached :photo

  include PgSearch::Model
  pg_search_scope :search_by_title, 
                  against: [:title, :content],
                  using: {
                    tsearch: { prefix: true } # <-- now `superman batm` will return something!
                  }
end
