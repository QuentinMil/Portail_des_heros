class CreatePartyCharacters < ActiveRecord::Migration[7.1]
  def change
    create_table :party_characters do |t|
      t.references :character, null: false, foreign_key: true
      t.references :party, null: false, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
