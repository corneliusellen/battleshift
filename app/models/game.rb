class Game < ApplicationRecord
  attr_accessor :messages
  has_many :game_players
  has_many :users, through: :game_players

  enum current_turn: ["challenger", "computer"]
  serialize :player_1_board
  serialize :player_2_board

  validates :player_1_board, presence: true
  validates :player_2_board, presence: true
end
