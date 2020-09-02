require 'rails_helper'

RSpec.describe "Shelter show Page" do
  describe "When I visit the shelters show page" do
    before(:each) do
      @shelter1 = Shelter.create!(name: "Paw Friends", address: "12345 NW. 32 St.", city: "Denver", state: "CO", zip: "80008")
      @shelter2 = Shelter.create!(name: "Denver County Animal Shelter", address: "56789 SW. 45 St.", city: "Denver", state: "CO", zip: "07070")
    end

    it "I a link to update the shelter" do
      visit "/shelters/#{@shelter1.id}"

      expect(page).to have_link("Update Shelter")
    end

    it "Link takes me to a form to edit the shelter's data." do
      visit "/shelters/#{@shelter1.id}"

      click_link "Update Shelter"

      expect(current_path).to eq("/shelters/#{@shelter1.id}/edit")

      fill_in :name, with: "Cool Pups Club"
      fill_in :address, with: "2345 PawPaw Lane"
      fill_in :city, with: "Aurora"
      fill_in :state, with: "CO"
      fill_in :zip, with: "67099"

      click_on "Update Shelter"

      expect(current_path).to eq("/shelters/#{@shelter1.id}")

      expect(page).to have_content("Cool Pups Club")
      expect(page).to_not have_content("Paw Friends")
    end

    it "Update shelter sad path" do
      visit "/shelters/#{@shelter1.id}"

      click_link "Update Shelter"

      expect(current_path).to eq("/shelters/#{@shelter1.id}/edit")

      fill_in :name, with: "Doggo House"
      fill_in :address, with: "87654 Doggo Lane"
      fill_in :city, with: "Boulder"
      fill_in :state, with: "CO"
      fill_in :zip, with: ""

      click_on "Update Shelter"

      expect(page).to have_content("Please fill out all fields before submission.")
    end
  end
end
