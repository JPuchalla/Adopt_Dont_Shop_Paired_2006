# User Story 6, Shelter Delete
#
# As a visitor
# When I visit a shelter show page
# Then I see a link to delete the shelter
# When I click the link "Delete Shelter"
# Then a 'DELETE' request is sent to '/shelters/:id',
# the shelter is deleted,
# and I am redirected to the shelter index page where I no longer see this shelter

require 'rails_helper'

RSpec.describe "Shelter show Page" do
  describe "When I visit the shelters show page" do
    before(:each) do
      @shelter1 = Shelter.create!(name: "Paw Friends", address: "12345 NW. 32 St.", city: "Denver", state: "CO", zip: "80008")
      @shelter2 = Shelter.create!(name: "Denver County Animal Shelter", address: "56789 SW. 45 St.", city: "Denver", state: "CO", zip: "07070")
    end

    it "I see a link to delete the shelter" do
      visit "/shelters/#{@shelter1.id}"

      expect(page).to have_link("Delete Shelter")
    end

    it "I click the link the shelter is deleted, on the shelter index page the shelter is deleted." do
      visit "/shelters/#{@shelter1.id}"

      click_link "Delete Shelter"

      expect(current_path).to eq("/shelters")

      expect(page).to_not have_content("Paw Friends")
      expect(page).to have_content("Denver County Animal Shelter")
    end
  end
end
