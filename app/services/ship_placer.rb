class ShipPlacer
  attr_reader :messages
  def initialize(board:, ship:, start_space:, end_space:)
    @board       = board
    @ship        = ship
    @start_space = start_space
    @end_space   = end_space
    @space_counter = 0
    @messages    = []
  end

  def run
    if same_row?
      place_in_row
    elsif same_column?
      place_in_column
    else
      raise InvalidShipPlacement.new("Ship must be in either the same row or column.")
    end
    @messages << "Successfully placed ship with a size of #{@ship.length}."
    determine_ships_to_place
  end

  def message
    @messages.join(" ")
  end

  private
  attr_reader :board, :ship,
    :start_space, :end_space

  def same_row?
    start_space[0] == end_space[0]
  end

  def same_column?
    start_space[1] == end_space[1]
  end

  def place_in_row
    row = start_space[0]
    range = start_space[1]..end_space[1]
    msg = "Ship size must be equal to the number of spaces you are trying to fill."
    raise InvalidShipPlacement.new(msg) unless range.count == ship.length.to_i
    range.each { |column| place_ship(row, column) }
  end

  def place_in_column
    column = start_space[1]
    range   = start_space[0]..end_space[0]
    raise InvalidShipPlacement unless range.count == ship.length.to_i
    range.each { |row| place_ship(row, column) }
  end

  def place_ship(row, column)
    coordinates = "#{row}#{column}"
    space = board.locate_space(coordinates)
    if space.occupied?
      raise InvalidShipPlacement.new("Attempting to place ship in a space that is already occupied.")
    else
      space.occupy!(ship)
    end
  end

  def determine_ships_to_place
    ship_counter
    if @space_counter == 5
      @messages << "You have 0 ship(s) to place."
    else
      @messages << "You have 1 ship(s) to place with a size of #{5 - @space_counter}."
    end
  end

  def ship_counter
    @board.board.each do |row|
      row.each do |space|
        if space.values[0].contents != nil
          @space_counter += 1
        end
      end
    end
  end
end
