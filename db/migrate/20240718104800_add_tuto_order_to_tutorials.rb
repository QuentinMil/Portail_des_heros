class AddTutoOrderToTutorials < ActiveRecord::Migration[7.1]
  def change
    add_column :tutorials, :tuto_order, :integer
  end
end
