require 'rails_helper'

RSpec.describe "Pets index page" do
  describe "When I visit the pets index page" do
    before(:each) do
      @shelter1 = Shelter.create!(name: "Paw Friends", address: "12345 NW. 32 St.", city: "Denver", state: "CO", zip: "80008")
      @shelter2 = Shelter.create!(name: "Denver County Animal Shelter", address: "56789 SW. 45 St.", city: "Denver", state: "CO", zip: "07070")

      @pet1 = @shelter1.pets.create!(image: "https://pyxis.nymag.com/v1/imgs/0c2/a83/4cfc644e76854d6cfe92f58219d2273a25-14-courage-the-cowardly-dog.rsquare.w700.jpg",name: "Courage",age: 2,sex: "M")
      @pet2 = @shelter2.pets.create!(image: "https://www.vieravet.com/sites/default/files/styles/large/adaptive-image/public/golden-retriever-dog-breed-info.jpg?itok=LCRMRkum",name: "Collins",age: 3,sex: "F")
    end

    it "I see each Pet in the system including the Pet's information and shelter" do
      visit '/pets'
      expect(page).to have_css("img[src*='#{@pet1.image}']")
      expect(page).to have_content("#{@pet1.name}")
      expect(page).to have_content("#{@pet1.age}")
      expect(page).to have_content("#{@pet1.sex}")
      expect(page).to have_content("#{@shelter1.name}")

      expect(page).to have_css("img[src*='#{@pet2.image}']")
      expect(page).to have_content("#{@pet2.name}")
      expect(page).to have_content("#{@pet2.age}")
      expect(page).to have_content("#{@pet2.sex}")
      expect(page).to have_content("#{@shelter2.name}")
    end

    it "I see an edit pet info link next to each pet, which takes me to the edit form." do
      visit '/pets'
      within "#pet-#{@pet1.id}" do
        expect(page).to have_content("#{@pet1.name}")
        expect(page).to have_link("Edit Pet Info")

        click_link "Edit Pet Info"
      end
      expect(current_path).to eq("/pets/#{@pet1.id}/edit")

      visit '/pets'
      within "#pet-#{@pet2.id}" do
        expect(page).to have_content("#{@pet2.name}")
        expect(page).to have_link("Edit Pet Info")

        click_link "Edit Pet Info"
      end
      expect(current_path).to eq("/pets/#{@pet2.id}/edit")
    end

    it "I see an edit pet info link next to each pet, which takes me to the edit form." do
      visit '/pets'
      within "#pet-#{@pet1.id}" do
        expect(page).to have_content("#{@pet1.name}")
        expect(page).to have_link("Delete Pet")

        click_link "Delete Pet"
      end
      expect(current_path).to eq("/pets")
      expect(page).to_not have_content("#{@pet1.name}")

      visit '/pets'
      within "#pet-#{@pet2.id}" do
        expect(page).to have_content("#{@pet2.name}")
        expect(page).to have_link("Edit Pet Info")

        click_link "Edit Pet Info"
      end
      expect(current_path).to eq("/pets/#{@pet2.id}/edit")
      expect(page).to_not have_content("#{@pet2.name}")
    end
  end
end
