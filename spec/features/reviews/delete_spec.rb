require "rails_helper"

RSpec.describe "Shelters Show Page Reviews" do
  describe "When I visit the shelters show page" do
    before(:each) do
      @shelter1 = Shelter.create!(name: "Paw Friends", address: "12345 NW. 32 St.", city: "Denver", state: "CO", zip: "80008")

      @review1 = @shelter1.reviews.create!(title: "Terrible Vet", rating: 2, content: "Dog poops everywhere. Not house trained.", image: "https://expertphotography.com/wp-content/uploads/2018/11/dog-photography-eyes.jpg")
      @review2 = @shelter1.reviews.create!(title: "Top notch service.", rating: 5, content: "Groomed my dog, she smells so good!")
    end

    it "I see a delete link next to each shelter review." do
      visit "/shelters/#{@shelter1.id}"

      within "#reviews-#{@review1.id}" do
        expect(page).to have_link("Delete Review")
        click_link "Delete Review"
      end

      expect(current_path).to eq("/shelters/#{@shelter1.id}")

      expect(page).to_not have_content(@review1.title)
    end
  end
end
