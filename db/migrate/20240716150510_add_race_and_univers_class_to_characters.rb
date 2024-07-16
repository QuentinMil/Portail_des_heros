class AddRaceAndUniversClassToCharacters < ActiveRecord::Migration[7.1]
  def change
    add_reference :characters, :race, null: false, foreign_key: true
    add_reference :characters, :univers_class, null: false, foreign_key: true
  end
end
