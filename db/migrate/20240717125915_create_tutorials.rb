class CreateTutorials < ActiveRecord::Migration[7.1]
  def change
    create_table :tutorials do |t|
      t.string :title
      t.text :content
      t.string :video_url
      t.references :universe, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
