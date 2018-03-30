require 'rails_helper'

describe User, type: :model do
  describe "relationships" do
    it { is_expected.to have_many(:player_1s) }
    it { is_expected.to have_many(:player_2s) }
  end

  it "is valid" do
    user = create(:user)

    expect(user).to be_valid
  end
end
