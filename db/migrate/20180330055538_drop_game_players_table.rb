class DropGamePlayersTable < ActiveRecord::Migration[5.1]
  def change
    drop_table :game_players
  end
end
