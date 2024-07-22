class AddRaceAndClassToTutorials < ActiveRecord::Migration[7.1]
  def change
    add_column :tutorials, :race, :string
    add_column :tutorials, :univers_class, :string
  end
end
