class AddDescriptionToRacesAndUniversClasses < ActiveRecord::Migration[7.1]
  def change
    add_column :races, :description, :text
    add_column :univers_classes, :description, :text
  end
end
