require 'spec_helper'
require './app/services/values/ship'
require './app/services/values/board'
require './app/services/values/space'

describe Ship do
  let(:board) { Board.new(4) }
  subject     { Ship.new(3) }

  it "exists when provided a board" do
    expect(subject).to be_a Ship
  end

  it "has ship in place" do
    subject.place("A1", "A3")

    expect(subject.length).to eq(3)
    expect(subject.start_space).to eq("A1")
    expect(subject.end_space).to eq("A3")
  end

  it "ship can take damage" do
    subject.place("A1", "A3")
    subject.attack!

    expect(subject.damage).to eq(1)
  end

  it "ship can sink" do
    subject.place("A1", "A3")
    subject.attack!
    subject.attack!
    subject.attack!

    expect(subject.is_sunk?).to be true
  end

  it "starts with damage at 0" do
    expect(subject.damage).to eq(0)
  end

  it "starts with spaces as nil" do
    expect(subject.start_space).to be nil
    expect(subject.end_space).to be nil
  end
end
