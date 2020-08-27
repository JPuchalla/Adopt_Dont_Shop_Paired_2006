require "rails_helper"

RSpec.describe "Shelters Show Page Reviews" do
  describe "When I visit the shelters show page" do
    before(:each) do
      @shelter1 = Shelter.create!(name: "Paw Friends", address: "12345 NW. 32 St.", city: "Denver", state: "CO", zip: "80008")

      @review1 = @shelter1.reviews.create!(title: "Terrible Vet", rating: 2, content: "Dog poops everywhere. Not house trained.", image: "https://expertphotography.com/wp-content/uploads/2018/11/dog-photography-eyes.jpg")
      @review2 = @shelter1.reviews.create!(title: "Top notch service.", rating: 5, content: "Groomed my dog, she smells so good!")
    end

    it "I see a link to edit a review for this shelter" do
      visit "/shelters/#{@shelter1.id}"

      within "#reviews-#{@review1.id}" do
        expect(page).to have_link("Edit Review")
        click_link "Edit Review"
        expect(current_path).to eq("/shelters/#{@shelter1.id}/reviews/#{@review1.id}/edit")
      end
    end

    it "I see a form to edit review information with pre-populated fields" do
      title = "Okay place"

      visit "/shelters/#{@shelter1.id}"
      within "#reviews-#{@review1.id}" do
        click_link "Edit Review"
      end

      expect(page).to have_selector("input[value='#{@review1.title}']")
      expect(page).to have_selector("input[value='#{@review1.rating}']")
      expect(page).to have_selector("input[value='#{@review1.content}']")

      fill_in :title, with: title

      click_on "Update Review"

      expect(current_path).to eq("/shelters/#{@shelter1.id}")

      expect(page).to have_content(title)
    end
  end
end

# User Story 6, Edit a Shelter Review, cont.
#
# As a visitor,
# When I fail to enter a title, a rating, and/or content in the edit shelter review form, but still try to submit the form
# I see a flash message indicating that I need to fill in a title, rating, and content in order to edit a shelter review
# And I'm returned to the edit form to edit that review
