class Board
  attr_reader :length,
              :board

  def initialize(length)
    @length = length
    @board = create_grid
  end

  def get_row_letters
    ("A".."Z").to_a.shift(@length)
  end

  def get_column_numbers
    ("1".."26").to_a.shift(@length)
  end

  def space_names
    get_row_letters.map do |letter|
      get_column_numbers.map do |number|
        letter + number
      end
    end.flatten
  end

  def create_spaces
    space_names.map do |name|
      [name, Space.new(name)]
    end.to_h
  end

  def assign_spaces_to_rows
    space_names.each_slice(@length).to_a
  end

  def create_grid
    spaces = create_spaces
    assign_spaces_to_rows.map do |row|
      row.each.with_index do |coordinates, index|
        row[index] = {coordinates => spaces[coordinates]}
      end
    end
  end

  def locate_space(coordinates)
    @board.each do |row|
      row.each do |space_hash|
        return space_hash[coordinates] if space_hash.keys[0] == coordinates
      end
    end
  end

  def same_row?(coordinate1, coordinate2)
    get_row(coordinate1) == get_row(coordinate2)
  end

  def same_column?(coordinate1, coordinate2)
    get_column(coordinate1) == get_column(coordinate2)
  end
end
