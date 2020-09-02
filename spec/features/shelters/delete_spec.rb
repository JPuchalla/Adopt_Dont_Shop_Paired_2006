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

    it "I don't see a button visible for deleting a shelter with pending pets." do
      @application1 = App.create!(name: "Bob Guy", address: "3888 Octavius st", city: "Denver", state: "Colorado", zip: "22212", phone_number: "7032220203", description: "Have a big yard and a brush.")
      @pet1 = @shelter1.pets.create!(image: "https://pyxis.nymag.com/v1/imgs/0c2/a83/4cfc644e76854d6cfe92f58219d2273a25-14-courage-the-cowardly-dog.rsquare.w700.jpg",name: "Courage",description: "Scared of everything except squirrels.", age: 2, sex: "M")
      @pet2 = @shelter2.pets.create!(image: "https://www.vieravet.com/sites/default/files/styles/large/adaptive-image/public/golden-retriever-dog-breed-info.jpg?itok=LCRMRkum",name: "Collins", description: "High energy with lots of lovins.", age: 3, sex: "F")
      PetApp.create!(pet_id: @pet1.id, app_id: @application1.id)
      PetApp.create!(pet_id: @pet2.id, app_id: @application1.id)

      visit "/apps/#{@application1.id}"
      within "#app_pets-#{@pet1.id}" do
        click_button("Approve Pet")
      end
      visit "/shelters"
      within "#shelter-#{@shelter1.id}" do
        expect(page).to_not have_link("Delete Shelter")
      end
      visit "/shelters/#{@shelter1.id}"
      expect(page).to_not have_link("Delete Shelter")
    end

    it "Shelters can be Deleted from shelters index as long as all pets do not have approved applications on them" do

      @application1 = App.create!(name: "Bob Guy", address: "3888 Octavius st", city: "Denver", state: "Colorado", zip: "22212", phone_number: "7032220203", description: "Have a big yard and a brush.")
      @pet1 = @shelter1.pets.create!(image: "https://pyxis.nymag.com/v1/imgs/0c2/a83/4cfc644e76854d6cfe92f58219d2273a25-14-courage-the-cowardly-dog.rsquare.w700.jpg",name: "Courage",description: "Scared of everything except squirrels.", age: 2, sex: "M")
      @pet2 = @shelter2.pets.create!(image: "https://www.vieravet.com/sites/default/files/styles/large/adaptive-image/public/golden-retriever-dog-breed-info.jpg?itok=LCRMRkum",name: "Collins", description: "High energy with lots of lovins.", age: 3, sex: "F")
      PetApp.create!(pet_id: @pet1.id, app_id: @application1.id)
      PetApp.create!(pet_id: @pet2.id, app_id: @application1.id)

      visit "/shelters"
      within "#shelter-#{@shelter1.id}" do
        click_link("Delete Shelter")
      end
      expect(page).to_not have_link(@shelter1.name)
    end

    it "Shelter can be Deleted from shelters show page as long as all pets do not have approved applications on them" do
      @application1 = App.create!(name: "Bob Guy", address: "3888 Octavius st", city: "Denver", state: "Colorado", zip: "22212", phone_number: "7032220203", description: "Have a big yard and a brush.")
      @pet1 = @shelter1.pets.create!(image: "https://pyxis.nymag.com/v1/imgs/0c2/a83/4cfc644e76854d6cfe92f58219d2273a25-14-courage-the-cowardly-dog.rsquare.w700.jpg",name: "Courage",description: "Scared of everything except squirrels.", age: 2, sex: "M")
      @pet2 = @shelter2.pets.create!(image: "https://www.vieravet.com/sites/default/files/styles/large/adaptive-image/public/golden-retriever-dog-breed-info.jpg?itok=LCRMRkum",name: "Collins", description: "High energy with lots of lovins.", age: 3, sex: "F")
      PetApp.create!(pet_id: @pet1.id, app_id: @application1.id)
      PetApp.create!(pet_id: @pet2.id, app_id: @application1.id)

      visit "/shelters/#{@shelter1.id}"
      click_link("Delete Shelter")
      expect(current_path).to eq("/shelters")
      expect(page).to_not have_link(@shelter1.name)
    end
  end
end
