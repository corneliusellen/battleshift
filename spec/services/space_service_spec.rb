require 'spec_helper'
require './app/services/values/board'
require './app/services/values/space'

describe Space do
  let(:board) { Board.new(4) }
  let(:ship)  { Ship.new(3) }
  subject     { Space.new("A1") }

  it "space exists when provided a board" do
    expect(subject).to be_a Space
  end

  it "changes the status when attacked" do
    expect(subject.contents).to be nil
    expect(subject.status).to eq("Not Attacked")

    subject.attack!

    expect(subject.status).to eq("Miss")
  end

  it "can be occupied" do
    subject.occupy!(ship)

    expect(subject.contents).to eq(ship)
  end
  #
  # it "ship can take damage" do
  #   subject.place("A1", "A3")
  #   subject.attack!
  #
  #   expect(subject.damage).to eq(1)
  # end
  #
  # it "ship can sink" do
  #   subject.place("A1", "A3")
  #   subject.attack!
  #   subject.attack!
  #   subject.attack!
  #
  #   expect(subject.is_sunk?).to be true
  # end
  #
  # it "starts with damage at 0" do
  #   expect(subject.damage).to eq(0)
  # end
  #
  # it "starts with spaces as nil" do
  #   expect(subject.start_space).to be nil
  #   expect(subject.end_space).to be nil
  # end
end
