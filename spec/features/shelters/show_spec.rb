require 'rails_helper'

RSpec.describe "Shelter show Page" do
  describe "When I visit the shelters show page" do
    before(:each) do
      @shelter1 = Shelter.create!(name: "Paw Friends", address: "12345 NW. 32 St.", city: "Denver", state: "CO", zip: "80008")
      @shelter2 = Shelter.create!(name: "Denver County Animal Shelter", address: "56789 SW. 45 St.", city: "Denver", state: "CO", zip: "07070")
    end

    it "I see that shelters information" do
      visit "/shelters/#{@shelter1.id}"

      expect(page).to have_content("#{@shelter1.name}")
      expect(page).to have_content("#{@shelter1.address}")
      expect(page).to have_content("#{@shelter1.city}")
      expect(page).to have_content("#{@shelter1.state}")
      expect(page).to have_content("#{@shelter1.zip}")

      expect(page).to_not have_content("#{@shelter2.name}")
    end
  end
end
