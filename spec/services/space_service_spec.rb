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

  it "can be occupied with contents" do
    subject.occupy!(ship)
    subject.occupied?

    expect(subject.contents).not_to be nil
  end

  it "starts with spaces not attacked" do
    subject.not_attacked?

    expect(subject.status).to eq("Not Attacked")
  end
end
