require 'rails_helper'

RSpec.describe "Pet Applications Show Page" do
  before(:each) do
    @shelter1 = Shelter.create!(name: "Paw Friends", address: "12345 NW. 32 St.", city: "Denver", state: "CO", zip: "80008")

    @pet1 = @shelter1.pets.create!(image: "https://pyxis.nymag.com/v1/imgs/0c2/a83/4cfc644e76854d6cfe92f58219d2273a25-14-courage-the-cowardly-dog.rsquare.w700.jpg",name: "Courage",description: "Scared of everything except squirrels.", age: 2, sex: "M")
    @pet2 = @shelter1.pets.create!(image: "https://www.vieravet.com/sites/default/files/styles/large/adaptive-image/public/golden-retriever-dog-breed-info.jpg?itok=LCRMRkum",name: "Collins", description: "High energy with lots of lovins.", age: 3, sex: "F")
    @pet3 = @shelter1.pets.create!(image: "https://i.barkpost.com/wp-content/uploads/2019/08/newfoundland-dog-featured-image.jpg?q=70&fit=crop&crop=entropy&w=808&h=500", name: "Charles", description: "Big and floofy.", age: 5, sex: "M")

    @application1 = App.create!(name: "Bob Guy", address: "3888 Octavius st", city: "Denver", state: "Colorado", zip: "22212", phone_number: "7032220203", description: "Have a big yard and a brush.")
    @application2 = App.create!(name: "Red Foreman", address: "4567 Show Rd.", city: "Milwaukee", state: "Wisconsin", zip: "98765", phone_number: "1234567890", description: "Too many kids hanging out in the basement.")

    PetApp.create!(pet_id: @pet1.id, app_id: @application1.id)
    PetApp.create!(pet_id: @pet1.id, app_id: @application2.id)
  end
  # User Story 22, Approving an Application

  # As a visitor
  # When I visit an application's show page
  # For every pet that the application is for, I see a link to approve the application for that specific pet
  # When I click on a link to approve the application for one particular pet
  # I'm taken back to that pet's show page
  # And I see that the pets status has changed to 'pending'
  # And I see text on the page that says who this pet is on hold for (Ex: "On hold for John Smith", given John Smith is the name on the application that was just accepted)

  it "Approving an Application" do
    visit "/apps/#{@application1.id}"
    expect(page).to have_button("Approve Pet")
    within "#app_pets-#{@pet1.id}" do
      click_button("Approve Pet")
    end

    expect(current_path).to eq("/pets/#{@pet1.id}")
    expect(page).to have_content("Status: Pending")
    expect(page).to have_content("On hold for #{@application1.name}")
  end
end
