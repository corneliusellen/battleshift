class AddMessagesToGames < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :messages, :string
  end
end
