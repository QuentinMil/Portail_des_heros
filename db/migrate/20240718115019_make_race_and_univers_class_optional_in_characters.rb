class MakeRaceAndUniversClassOptionalInCharacters < ActiveRecord::Migration[7.1]
  def change
    change_column_null :characters, :race_id, true
    change_column_null :characters, :univers_class_id, true
  end
end
