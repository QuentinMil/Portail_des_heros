class RemoveCategoryTutorialAndUserFromPosts < ActiveRecord::Migration[7.1]
  def change
    remove_column :posts, :category, :string
    remove_column :posts, :tutorial, :boolean
    remove_reference :posts, :user, foreign_key: true
  end
end
