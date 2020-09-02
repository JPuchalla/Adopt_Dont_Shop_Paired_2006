require 'rails_helper'

RSpec.describe "Pets show Page" do
  describe "When I visit the spets show page" do
    before(:each) do
      @shelter1 = Shelter.create!(name: "Paw Friends", address: "12345 NW. 32 St.", city: "Denver", state: "CO", zip: "80008")
      @pet1 = @shelter1.pets.create!(image: "https://pyxis.nymag.com/v1/imgs/0c2/a83/4cfc644e76854d6cfe92f58219d2273a25-14-courage-the-cowardly-dog.rsquare.w700.jpg",name: "Courage",description: "Scared of everything except squirrels.", age: 2, sex: "M")
      @pet2 = @shelter1.pets.create!(image: "https://www.vieravet.com/sites/default/files/styles/large/adaptive-image/public/golden-retriever-dog-breed-info.jpg?itok=LCRMRkum",name: "Collins", description: "High energy with lots of lovins.", age: 3, sex: "F")
    end

    it "I see a link to delete the pet" do
      visit "/pets/#{@pet1.id}"

      expect(page).to have_link("Delete Pet")
    end

    it "I click the link & the pet is deleted, on the pet index page the pet is deleted." do
      visit "/pets/#{@pet1.id}"

      click_link "Delete Pet"

      expect(current_path).to eq("/pets")

      expect(page).to_not have_content(@pet1.name)
      expect(page).to have_content(@pet2.name)
    end

    it "Pets with approved applications cannot be deleted from index page" do
      @application1 = App.create!(name: "Bob Guy", address: "3888 Octavius st", city: "Denver", state: "Colorado", zip: "22212", phone_number: "7032220203", description: "Have a big yard and a brush.")
      PetApp.create!(pet_id: @pet1.id, app_id: @application1.id)

      visit "/apps/#{@application1.id}"
      within "#app_pets-#{@pet1.id}" do
        click_button("Approve Pet")
      end

      visit "/pets"

      within "#pet-#{@pet1.id}" do
        expect(page).to_not have_link("Delete Pet")
      end
    end
    it "Pets with approved applications cannot be deleted from show page" do
      @application1 = App.create!(name: "Bob Guy", address: "3888 Octavius st", city: "Denver", state: "Colorado", zip: "22212", phone_number: "7032220203", description: "Have a big yard and a brush.")
      PetApp.create!(pet_id: @pet1.id, app_id: @application1.id)

      visit "/apps/#{@application1.id}"
      within "#app_pets-#{@pet1.id}" do
        click_button("Approve Pet")
      end

      visit "/pets/#{@pet1.id}"
      expect(page).to_not have_link("Delete Pet")
    end
  end
end
