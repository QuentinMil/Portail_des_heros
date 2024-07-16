class CreateCharacters < ActiveRecord::Migration[7.1]
  def change
    create_table :characters do |t|
      t.string :name
      t.references :user, null: false, foreign_key: true
      t.references :universe, null: false, foreign_key: true
      t.string :strength
      t.string :dexterity
      t.string :intelligence
      t.string :constitution
      t.string :wisdom
      t.string :charisma
      t.string :available_status

      t.timestamps
    end
  end
end
