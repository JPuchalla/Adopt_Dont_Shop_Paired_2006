require 'rails_helper'

RSpec.describe "Shelter pets index page" do
  describe "When I visit the shelter pets index page" do
    before(:each) do
      @shelter1 = Shelter.create!(name: "Paw Friends", address: "12345 NW. 32 St.", city: "Denver", state: "CO", zip: "80008")
      @shelter2 = Shelter.create!(name: "Denver County Animal Shelter", address: "56789 SW. 45 St.", city: "Denver", state: "CO", zip: "07070")

      @pet1 = @shelter1.pets.create!(image: "https://pyxis.nymag.com/v1/imgs/0c2/a83/4cfc644e76854d6cfe92f58219d2273a25-14-courage-the-cowardly-dog.rsquare.w700.jpg",name: "Courage",description: "Scared of everything except squirrels.", age: 2, sex: "M")
      @pet2 = @shelter1.pets.create!(image: "https://www.vieravet.com/sites/default/files/styles/large/adaptive-image/public/golden-retriever-dog-breed-info.jpg?itok=LCRMRkum",name: "Collins", description: "High energy with lots of lovins.", age: 3, sex: "F")
      @pet3 = @shelter1.pets.create!(image: "https://i.barkpost.com/wp-content/uploads/2019/08/newfoundland-dog-featured-image.jpg?q=70&fit=crop&crop=entropy&w=808&h=500", name: "Charles", description: "Big and floofy.", age: 5, sex: "M")

    end

    it "I see a link to add a new adoptable pet" do
      visit "/shelters/#{@shelter1.id}/pets"

      expect(page).to have_link("Add New Pet")
    end

    it "The link takes me to a form to add a new adoptable pet. The pet status is 'adoptable' by default." do

      visit "/shelters/#{@shelter1.id}/pets"

      click_link "Add New Pet"

      expect(current_path).to eq("/shelters/#{@shelter1.id}/pets/new")

      fill_in :image, with: "https://i.chzbgr.com/original/2362885/hAB13D999/people-just-cant-stop-photoshopping-this-funny-looking-dog-with-a-gigantic-tongue"
      fill_in :name, with: "Zippy"
      fill_in :description, with: "Gots a big toungue. Very good boy."
      fill_in :age, with: 7
      fill_in :sex, with: "M"

      click_on "Create Pet"

      expect(current_path).to eq("/shelters/#{@shelter1.id}/pets")
      expect(page).to have_content("Zippy")
      expect(page).to have_content(7)
    end

    it "Create Pet sad path" do
      visit "/shelters/#{@shelter1.id}/pets"

      click_link "Add New Pet"


      fill_in :image, with: "https://i.chzbgr.com/original/2362885/hAB13D999/people-just-cant-stop-photoshopping-this-funny-looking-dog-with-a-gigantic-tongue"
      fill_in :name, with: "Zippy"
      fill_in :description, with: "Gots a big toungue. Very good boy."
      fill_in :age, with: 7
      fill_in :sex, with: ""

      click_on "Create Pet"

      expect(page).to have_content("Fill in all fields before submission.")

    end

    # User Story 33, Flash Message for Pet Create and Update
    #
    # As a visitor
    # When I am updating or creating a pet
    # If I try to submit the form with incomplete information
    # I see a flash message indicating which field(s) I am missing
    # ```
  end
end
