class AddCompletionRateToCharacters < ActiveRecord::Migration[7.1]
  def change
    add_column :characters, :completion_rate, :integer
  end
end
