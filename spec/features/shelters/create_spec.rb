require 'rails_helper'

RSpec.describe "Shelter index Page" do
  describe "When I visit the shelters index page" do
    it "I see a link to create a new Shelter" do
      visit "/shelters"

      expect(page).to have_link("New Shelter")
    end

    it "The link takes me to a form for a new shelter" do
      visit "/shelters"

      click_link "New Shelter"

      expect(current_path).to eq('/shelters/new')

      fill_in :name, with: "Doggo House"
      fill_in :address, with: "87654 Doggo Lane"
      fill_in :city, with: "Boulder"
      fill_in :state, with: "CO"
      fill_in :zip, with: "90876"

      click_on "Create Shelter"

      expect(current_path).to eq("/shelters")
      expect(page).to have_content("Doggo House")
    end

    it "New Shelter sad path" do
      visit "/shelters"

      click_link "New Shelter"

      expect(current_path).to eq('/shelters/new')

      fill_in :name, with: "Doggo House"
      fill_in :address, with: "87654 Doggo Lane"
      fill_in :city, with: "Boulder"
      fill_in :state, with: "CO"
      fill_in :zip, with: ""

      click_on "Create Shelter"

      expect(page).to have_content("Please fill out all fields before submission.")
    end
  end
end
