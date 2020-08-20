require 'rails_helper'

RSpec.describe "Pets show page" do
  describe "When I visit the pets show page" do
    before(:each) do
      @shelter1 = Shelter.create!(name: "Paw Friends", address: "12345 NW. 32 St.", city: "Denver", state: "CO", zip: "80008")
      @shelter2 = Shelter.create!(name: "Denver County Animal Shelter", address: "56789 SW. 45 St.", city: "Denver", state: "CO", zip: "07070")

      @pet1 = @shelter1.pets.create!(image: "https://pyxis.nymag.com/v1/imgs/0c2/a83/4cfc644e76854d6cfe92f58219d2273a25-14-courage-the-cowardly-dog.rsquare.w700.jpg",name: "Courage",description: "Scared of everything except squirrels.", age: 2, sex: "M")
      @pet2 = @shelter1.pets.create!(image: "https://www.vieravet.com/sites/default/files/styles/large/adaptive-image/public/golden-retriever-dog-breed-info.jpg?itok=LCRMRkum",name: "Collins", description: "High energy with lots of lovins.", age: 3, sex: "F")
      @pet3 = @shelter1.pets.create!(image: "https://i.barkpost.com/wp-content/uploads/2019/08/newfoundland-dog-featured-image.jpg?q=70&fit=crop&crop=entropy&w=808&h=500", name: "Charles", description: "Big and floofy.", age: 5, sex: "M")

    end

    it "I a link to edit the pets info" do
      visit "/pets/#{@pet1.id}"

      expect(page).to have_link("Edit Pet Info")
    end

    it "Link takes me to a form to edit the pets info." do
      visit "/pets/#{@pet1.id}"

      click_link "Edit Pet Info"

      expect(current_path).to eq("/pets/#{@pet1.id}/edit")

      fill_in :image, with: "https://i.chzbgr.com/original/2362885/hAB13D999/people-just-cant-stop-photoshopping-this-funny-looking-dog-with-a-gigantic-tongue"
      fill_in :name, with: "Marv"
      fill_in :description, with: "Gots a big toungue. Very good boy."
      fill_in :age, with: 15
      fill_in :sex, with: "M"

      click_on "Update Pet"

      expect(current_path).to eq("/pets/#{@pet1.id}")

      expect(page).to have_content("Marv")
      expect(page).to have_content(15)
      expect(page).to_not have_content("Courage")
    end
  end
end
