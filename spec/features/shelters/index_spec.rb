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

    it "I see an update shelter link next to each shelter, which takes me to the edit form." do
      visit '/shelters'
      within "#shelter-#{@shelter1.id}" do
        expect(page).to have_content("#{@shelter1.name}")
        expect(page).to have_link("Update Shelter")

        click_link "Update Shelter"
      end
      expect(current_path).to eq("/shelters/#{@shelter1.id}/edit")

      visit '/shelters'
      within "#shelter-#{@shelter2.id}" do
        expect(page).to have_content("#{@shelter2.name}")
        expect(page).to have_link("Update Shelter")

        click_link "Update Shelter"
      end
      expect(current_path).to eq("/shelters/#{@shelter2.id}/edit")
    end

    it "I see a delete shelter link next to each shelter." do
      visit '/shelters'
      within "#shelter-#{@shelter1.id}" do
        expect(page).to have_content("#{@shelter1.name}")
        expect(page).to have_link("Delete Shelter")

        click_link "Delete Shelter"
      end
      expect(current_path).to eq("/shelters")
      expect(page).to_not have_content("#{@shelter1.name}")

      visit '/shelters'
      within "#shelter-#{@shelter2.id}" do
        expect(page).to have_content("#{@shelter2.name}")
        expect(page).to have_link("Delete Shelter")

        click_link "Delete Shelter"
      end
      expect(current_path).to eq("/shelters")
      expect(page).to_not have_content("#{@shelter2.name}")
    end
  end
end
