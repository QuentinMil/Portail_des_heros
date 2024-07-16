class CreateUniverses < ActiveRecord::Migration[7.1]
  def change
    create_table :universes do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
