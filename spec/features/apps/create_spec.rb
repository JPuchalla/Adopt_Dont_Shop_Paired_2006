require 'rails_helper'

RSpec.describe "Apply for pets" do
  before(:each) do
    @shelter1 = Shelter.create!(name: "Paw Friends", address: "12345 NW. 32 St.", city: "Denver", state: "CO", zip: "80008")

    @pet1 = @shelter1.pets.create!(image: "https://pyxis.nymag.com/v1/imgs/0c2/a83/4cfc644e76854d6cfe92f58219d2273a25-14-courage-the-cowardly-dog.rsquare.w700.jpg",name: "Courage",description: "Scared of everything except squirrels.", age: 2, sex: "M")
    @pet2 = @shelter1.pets.create!(image: "https://www.vieravet.com/sites/default/files/styles/large/adaptive-image/public/golden-retriever-dog-breed-info.jpg?itok=LCRMRkum",name: "Collins", description: "High energy with lots of lovins.", age: 3, sex: "F")
    @pet3 = @shelter1.pets.create!(image: "https://i.barkpost.com/wp-content/uploads/2019/08/newfoundland-dog-featured-image.jpg?q=70&fit=crop&crop=entropy&w=808&h=500", name: "Charles", description: "Big and floofy.", age: 5, sex: "M")
  end

  it "On favorites page I see a button to apply for pets." do
    visit "/pets/#{@pet1.id}"
    click_button "Add To Favorites"

    visit "/pets/#{@pet2.id}"
    click_button "Add To Favorites"

    visit "/pets/#{@pet3.id}"
    click_button "Add To Favorites"

    visit "/favorites"

    expect(page).to have_button("Apply For Pets")
  end

  it "Button take me to a create form." do
    visit "/pets/#{@pet1.id}"
    click_button "Add To Favorites"

    visit "/pets/#{@pet2.id}"
    click_button "Add To Favorites"

    visit "/pets/#{@pet3.id}"
    click_button "Add To Favorites"

    visit "/favorites"

    click_button "Apply For Pets"

    expect(current_path).to eq("/apps/new")

    check "select-#{@pet1.name.downcase}"
    uncheck "select-#{@pet1.name.downcase}"

    expect(page).to have_field(:name)
    expect(page).to have_field(:address)
    expect(page).to have_field(:city)

    check "select-#{@pet1.name.downcase}"
    check "select-#{@pet2.name.downcase}"
    fill_in :name, with: "Bob Guy"
    fill_in :address, with: "12345 Wallaby Way"
    fill_in :city, with: "Boise"
    fill_in :state, with: "ID"
    fill_in :zip, with: "98765"
    fill_in :phone_numer, with: "123-456-7890"
    fill_in :description, with: "Need a good ranch dog."
    click_button "Submit Application"

    expect(current_path).to eq("/favorites")
    expect(page).to have_content("Application successfully submitted!")

    expect(page).to_not have_content(@pet1.name)
  end
end
