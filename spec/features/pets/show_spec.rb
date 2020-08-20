require 'rails_helper'

RSpec.describe "Pet show page" do
  describe "When I visit a pets show page" do
    before(:each) do
      @shelter1 = Shelter.create!(name: "Paw Friends", address: "12345 NW. 32 St.", city: "Denver", state: "CO", zip: "80008")

      @pet2 = @shelter1.pets.create!(image: "https://www.vieravet.com/sites/default/files/styles/large/adaptive-image/public/golden-retriever-dog-breed-info.jpg?itok=LCRMRkum", name: "Collins", description: "High energy with lots of lovins.", age: 3, sex: "F")
    end

    it "I see the pet information with that id including the pet's adoption status" do
      visit "/pets/#{@pet2.id}"

      expect(page).to have_css("img[src*='#{@pet2.image}']")
      expect(page).to have_content("#{@pet2.name}")
      expect(page).to have_content("#{@pet2.description}")
      expect(page).to have_content("#{@pet2.age}")
      expect(page).to have_content("#{@pet2.sex}")
      expect(page).to have_content("Adoptable")
    end
  end
end
