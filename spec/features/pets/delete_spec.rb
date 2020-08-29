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
  end
  
end
