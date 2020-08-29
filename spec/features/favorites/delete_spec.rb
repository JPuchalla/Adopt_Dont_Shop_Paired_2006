require 'rails_helper'

RSpec.describe "Pet favorites delete spec" do
  before :each do
    @shelter1 = Shelter.create!(name: "Paw Friends", address: "12345 NW. 32 St.", city: "Denver", state: "CO", zip: "80008")

    @pet1 = @shelter1.pets.create!(image: "https://pyxis.nymag.com/v1/imgs/0c2/a83/4cfc644e76854d6cfe92f58219d2273a25-14-courage-the-cowardly-dog.rsquare.w700.jpg",name: "Courage",description: "Scared of everything except squirrels.", age: 2, sex: "M")
  end

  it "favorite a pet link is replaced with remove button once pet is favorited" do
    visit "/pets/#{@pet1.id}"
    click_button "Add To Favorites"
    expect(current_path).to eq("/pets/#{@pet1.id}")
    expect(page).to_not have_button("Add To Favorites")
    expect(page).to have_button("Remove From Favorites")
    click_button "Remove From Favorites"
    expect(current_path).to eq("/pets/#{@pet1.id}")
    expect(page).to have_button("Add To Favorites")
    expect(page).to_not have_button("Remove From Favorites")
    expect(page).to have_content("#{@pet1.name} has been removed from your favorites.")
    within ".navbar" do
      expect(page).to have_content("Favorites: 0")
    end
  end
end
