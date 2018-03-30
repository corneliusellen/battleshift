class Message

  def initialize(game)
    @game = game
    @space_counter = 0
  end

  def placing_ships_messages(ship_size)
    ship_counter
    if @space_counter == 5
      ships_placed_message(ship_size) + "You have 0 ship(s) to place."
    elsif @space_counter > 0
      ships_placed_message(ship_size) + ships_to_place_message
    else
      "You need to place 2 ships."
    end
  end

  def ships_placed_message(ship_size)
    "Successfully placed ship with a size of #{ship_size}. "
  end

  def ships_to_place_message
    "You have 1 ship(s) to place with a size of #{5 - @space_counter}."
  end

  def ship_counter
    @game.player_1_board.board.each do |row|
      row.each do |space|
        if space.values[0].contents != nil
          @space_counter += 1
        end
      end
    end
  end

end
