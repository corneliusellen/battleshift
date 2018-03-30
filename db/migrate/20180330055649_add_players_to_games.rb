class AddPlayersToGames < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :player_1_id, :integer
    add_column :games, :player_2_id, :integer
  end
end
