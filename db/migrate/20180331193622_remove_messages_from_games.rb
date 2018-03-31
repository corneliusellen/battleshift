class RemoveMessagesFromGames < ActiveRecord::Migration[5.1]
  def change
    remove_column :games, :messages, :string
  end
end
