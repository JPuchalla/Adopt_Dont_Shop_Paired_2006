require 'rails_helper'

RSpec.describe "Shelter show Page" do
  describe "When I visit the shelters show page" do
    before(:each) do
      @shelter1 = Shelter.create!(name: "Paw Friends", address: "12345 NW. 32 St.", city: "Denver", state: "CO", zip: "80008")
      @shelter2 = Shelter.create!(name: "Denver County Animal Shelter", address: "56789 SW. 45 St.", city: "Denver", state: "CO", zip: "07070")

      @pet1 = @shelter1.pets.create!(image: "https://pyxis.nymag.com/v1/imgs/0c2/a83/4cfc644e76854d6cfe92f58219d2273a25-14-courage-the-cowardly-dog.rsquare.w700.jpg",name: "Courage",description: "Scared of everything except squirrels.", age: 2, sex: "M")
      @pet2 = @shelter1.pets.create!(image: "https://www.vieravet.com/sites/default/files/styles/large/adaptive-image/public/golden-retriever-dog-breed-info.jpg?itok=LCRMRkum",name: "Collins", description: "High energy with lots of lovins.", age: 3, sex: "F")

      @review1 = @shelter1.reviews.create!(title: "Terrible Vet", rating: 2, content: "Dog poops everywhere. Not house trained.", image: "https://expertphotography.com/wp-content/uploads/2018/11/dog-photography-eyes.jpg")
      @review2 = @shelter1.reviews.create!(title: "Top notch service.", rating: 5, content: "Groomed my dog, she smells so good!")
    end

    it "I see that shelters information" do
      visit "/shelters/#{@shelter1.id}"

      expect(page).to have_content("#{@shelter1.name}")
      expect(page).to have_content("#{@shelter1.address}")
      expect(page).to have_content("#{@shelter1.city}")
      expect(page).to have_content("#{@shelter1.state}")
      expect(page).to have_content("#{@shelter1.zip}")

      expect(page).to_not have_content("#{@shelter2.name}")
    end

    it "I see a link to that shelters pets page" do
      visit "/shelters/#{@shelter1.id}"

      expect(page).to have_link("#{@shelter1.name} Pet's")

      click_link "#{@shelter1.name} Pet's"

      expect(current_path).to eq("/shelters/#{@shelter1.id}/pets")
    end

    it "I see a list of reviews for that shelter" do
      visit "/shelters/#{@shelter1.id}"

      expect(page).to have_content("#{@review1.title}")
      expect(page).to have_content("#{@review1.rating}")
      expect(page).to have_content("#{@review1.content}")
      expect(page).to have_css("img[src*='#{@review1.image}']")
    end

    it "Shelter Statistics" do
      @application1 = App.create!(name: "Bob Guy", address: "3888 Octavius st", city: "Denver", state: "Colorado", zip: "22212", phone_number: "7032220203", description: "Have a big yard and a brush.")
      @application2 = App.create!(name: "Red Foreman", address: "4567 Show Rd.", city: "Milwaukee", state: "Wisconsin", zip: "98765", phone_number: "1234567890", description: "Too many kids hanging out in the basement.")
      PetApp.create!(pet_id: @pet1.id, app_id: @application1.id)
      PetApp.create!(pet_id: @pet1.id, app_id: @application2.id)

      visit "/shelters/#{@shelter1.id}"

      expect(page).to have_content("Pets: 2")
      expect(page).to have_content("Average Rating: 3.5")
      expect(page).to have_content("Number of Applications: 2")
    end
  end
end
