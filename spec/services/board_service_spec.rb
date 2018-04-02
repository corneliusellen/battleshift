require 'spec_helper'
require './app/services/values/board'

describe Board do
  subject           { Board.new(4) }
  let(:ship)     { Ship.new(3) }
  let(:ship_placer) { ShipPlacer.new(board: subject, ship: ship, start_space: "A1", end_space: "A2") }


  it "exists when provided a instatiated" do
    expect(subject).to be_a Board
  end

  it "gets row letters and column numbers" do
    expect(subject.get_row_letters.last).to eq("D")
    expect(subject.get_column_numbers.last).to eq("4")

    subject.space_names

    expect(subject.space_names.first).to eq("A1")
  end

  it "can create spaces" do
    subject.create_spaces

    expect(subject.board[3].first["D1"]).not_to be nil
  end

  it "can be occupied with contents" do
    result = subject.assign_spaces_to_rows

    expect(result.first[2]).to eq("A3")
  end

  it "can create the grid" do
    result = subject.create_grid

    expect(result.last[2]).not_to be nil
  end

  it "can locate a space" do
    result = subject.locate_space("A2")

    expect(result.coordinates).to eq("A2")
  end
end
