class CreateUniversClasses < ActiveRecord::Migration[7.1]
  def change
    create_table :univers_classes do |t|
      t.string :name
      t.references :universe, null: false, foreign_key: true

      t.timestamps
    end
  end
end
