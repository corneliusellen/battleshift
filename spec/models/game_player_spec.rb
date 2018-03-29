require 'rails_helper'

describe GamePlayer, type: :model do
  describe "relationships" do
    it { is_expected.to belong_to(:player_1) }
    it { is_expected.to belong_to(:player_2) }
    it { is_expected.to belong_to(:game) }
  end
end
