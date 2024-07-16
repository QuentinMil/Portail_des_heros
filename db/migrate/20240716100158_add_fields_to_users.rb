class AddFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :pseudo, :string
    add_column :users, :player_level, :string
    add_column :users, :game_master, :boolean
    add_column :users, :admin, :boolean
    add_column :users, :completion_rate_basics, :integer, default: 0
    add_column :users, :completion_rate_universes, :integer, default: 0
    add_column :users, :completion_rate_characters, :integer, default: 0
  end
end
