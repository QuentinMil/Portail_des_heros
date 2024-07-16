class CreateNotes < ActiveRecord::Migration[7.1]
  def change
    create_table :notes do |t|
      t.text :user_notes
      t.text :other_notes
      t.references :character, null: false, foreign_key: true

      t.timestamps
    end
  end
end
