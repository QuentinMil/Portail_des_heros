class Post < ApplicationRecord
  validates :title, :content, presence: true
  has_one_attached :photo

  include PgSearch::Model

  pg_search_scope :search_by_title_and_content, 
                  against: [:title, :content],
                  using: {
                    tsearch: { prefix: true } # Le préfixe permet des correspondances partielles
                  }
end
