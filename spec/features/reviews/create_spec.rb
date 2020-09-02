require "rails_helper"

RSpec.describe "Shelters Show Page Reviews" do
  describe "When I visit the shelters show page" do
    before(:each) do
      @shelter1 = Shelter.create!(name: "Paw Friends", address: "12345 NW. 32 St.", city: "Denver", state: "CO", zip: "80008")

      @review1 = @shelter1.reviews.create!(title: "Terrible Vet", rating: 2, content: "Dog poops everywhere. Not house trained.", image: "https://expertphotography.com/wp-content/uploads/2018/11/dog-photography-eyes.jpg")
      @review2 = @shelter1.reviews.create!(title: "Top notch service.", rating: 5, content: "Groomed my dog, she smells so good!")
    end

    it "I see a link to add a new review for this shelter" do
      visit "/shelters/#{@shelter1.id}"
      expect(page).to have_link("New Review")
      click_link "New Review"
      expect(current_path).to eq("/shelters/#{@shelter1.id}/reviews/new")
    end

    it "I see a form to enter in review information and redirected to show page" do
      title = "Okay place"
      rating = 3
      content = "Nothing special. Just average."

      visit "/shelters/#{@shelter1.id}"
      click_link "New Review"

      fill_in :title, with: title
      fill_in :rating, with: rating
      fill_in :content, with: content

      click_on "Create Review"

      expect(current_path).to eq("/shelters/#{@shelter1.id}")

      expect(page).to have_content(title)
    end

    it "Create review sad path" do

      visit "/shelters/#{@shelter1.id}"
      click_link "New Review"

      fill_in :title, with: "Okay place"
      fill_in :rating, with: ""
      fill_in :content, with: "Nothing special. Just average."

      click_on "Create Review"

      expect(page).to have_content("Please enter title, rating, and content in order to submit a review.")
    end
  end
end
