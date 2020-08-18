require 'rails_helper'

RSpec.describe "Shelters Index Page" do
  describe "When I visit the shelters index page" do
    before(:each) do
      @shelter1 = Shelter.create!(name: "Paw Friends", address: "12345 NW. 32 St.", city: "Denver", state: "CO", zip: "80008")
      @shelter2 = Shelter.create!(name: "Denver County Animal Shelter", address: "56789 SW. 45 St.", city: "Denver", state: "CO", zip: "07070")
    end

    it "I see the name of each shelter in the system" do
      visit '/shelters'

      expect(page).to have_content("#{@shelter1.name}")
      expect(page).to have_content("#{@shelter2.name}")
    end
  end
end
