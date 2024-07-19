class AddBackstoryToCharacters < ActiveRecord::Migration[7.1]
  def change
    add_column :characters, :backstory, :text
  end
end
