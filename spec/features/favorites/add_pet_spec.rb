require 'rails_helper'

RSpec.describe "Pet favorites spec" do
  before :each do
    @shelter1 = Shelter.create!(name: "Paw Friends", address: "12345 NW. 32 St.", city: "Denver", state: "CO", zip: "80008")

    @pet1 = @shelter1.pets.create!(image: "https://www.vieravet.com/sites/default/files/styles/large/adaptive-image/public/golden-retriever-dog-breed-info.jpg?itok=LCRMRkum",
      name: "Collins",
      description: "High energy with lots of lovins.",
      age: 3,
      sex: "F")
  end

  it "Has favorite indicator in my navigation bar" do
    visit "/"
     within(".navbar") do
       expect(page).to have_content("Favorites: 0")
    end
  end

  it "I can favorite pets and I see a flash message indicating they are added to favorites." do
    visit "/pets/#{@pet1.id}"

    expect(page).to have_button("Add To Favorites")

    click_button "Add To Favorites"

    expect(current_path).to eq("/pets/#{@pet1.id}")

    expect(page).to have_content("You have added #{@pet1.name} to your favorites.")

    within(".navbar") do
      expect(page).to have_content("Favorites: 1")
    end
  end
end
