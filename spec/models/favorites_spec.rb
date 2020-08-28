require 'rails_helper'

RSpec.describe Favorites do

  describe "#total_count" do
    it "Totals the count of favorited pets" do
      favorites = Favorites.new({
        '1' => 3,
        '2' => 3
      })
      expect(favorites.total_count).to eq(6)
    end
  end
end
