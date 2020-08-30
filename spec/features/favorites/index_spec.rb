require 'rails_helper'

RSpec.describe "Pet favorites index spec" do
  before :each do
    @shelter1 = Shelter.create!(name: "Paw Friends", address: "12345 NW. 32 St.", city: "Denver", state: "CO", zip: "80008")

    @pet1 = @shelter1.pets.create!(image: "https://pyxis.nymag.com/v1/imgs/0c2/a83/4cfc644e76854d6cfe92f58219d2273a25-14-courage-the-cowardly-dog.rsquare.w700.jpg",name: "Courage",description: "Scared of everything except squirrels.", age: 2, sex: "M")
    @pet2 = @shelter1.pets.create!(image: "https://www.vieravet.com/sites/default/files/styles/large/adaptive-image/public/golden-retriever-dog-breed-info.jpg?itok=LCRMRkum",name: "Collins", description: "High energy with lots of lovins.", age: 3, sex: "F")
    @pet3 = @shelter1.pets.create!(image: "https://i.barkpost.com/wp-content/uploads/2019/08/newfoundland-dog-featured-image.jpg?q=70&fit=crop&crop=entropy&w=808&h=500", name: "Charles", description: "Big and floofy.", age: 5, sex: "M")
    @application1 = App.create!(name: "Bob Guy", address: "3888 Octavius st", city: "Denver", state: "Colorado", zip: "22212", phone_number: "7032220203", description: "Have a big yard and a brush.")

    PetApp.create!(pet_id: @pet1.id, app_id: @application1.id)
    PetApp.create!(pet_id: @pet2.id, app_id: @application1.id)
  end

  it "When I visit the index page, I see all favorited pets" do
    visit "/pets/#{@pet1.id}"
    click_button "Add To Favorites"

    visit "/pets/#{@pet2.id}"
    click_button "Add To Favorites"

    visit "/favorites"

    expect(page).to have_link("#{@pet1.name}")
    expect(page).to have_css("img[src*='#{@pet1.image}']")

    expect(page).to have_link("#{@pet2.name}")
    expect(page).to have_css("img[src*='#{@pet2.image}']")
  end


  it "When I click on favorites indicator I'm taken to its index page" do
    visit "/"
    click_link "Favorites: 0"
    expect(current_path).to eq("/favorites")
  end

  it "No Favorites Page flash message" do
    visit "/favorites"
    within ".navbar" do
      expect(page).to have_content("Favorites: 0")
    end
    expect(page).to have_content("No favorited pets.")
  end

  it "List of Pets that have applications on them" do
    visit "/favorites"
    within ".applied_pets" do
      expect(page).to have_link(@pet1.name)
      expect(page).to have_link(@pet2.name)
    end
  end
end
