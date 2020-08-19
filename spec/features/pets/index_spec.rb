require 'rails_helper'

RSpec.describe "" do
  describe "When I visit the pets index page" do
    before(:each) do
      @shelter1 = Shelter.create!(name: "Paw Friends", address: "12345 NW. 32 St.", city: "Denver", state: "CO", zip: "80008")
      @shelter2 = Shelter.create!(name: "Denver County Animal Shelter", address: "56789 SW. 45 St.", city: "Denver", state: "CO", zip: "07070")

      @pet1 = @shelter1.pets.create!(image: "https://pyxis.nymag.com/v1/imgs/0c2/a83/4cfc644e76854d6cfe92f58219d2273a25-14-courage-the-cowardly-dog.rsquare.w700.jpg",name: "Courage",age: 2,sex: "M")
      @pet2 = @shelter1.pets.create!(image: "https://www.vieravet.com/sites/default/files/styles/large/adaptive-image/public/golden-retriever-dog-breed-info.jpg?itok=LCRMRkum",name: "Collins",age: 3,sex: "F")
      @pet3 = @shelter1.pets.create!(image: "https://i.barkpost.com/wp-content/uploads/2019/08/newfoundland-dog-featured-image.jpg?q=70&fit=crop&crop=entropy&w=808&h=500",name: "Charles",age: 5,sex: "M")
    end

    it "I see each Pet in the system including the Pet's information and shelter" do
      visit '/pets'
      expect(page).to have_css("img[src*='#{@pet1.image}']")
      expect(page).to have_content("#{@pet1.name}")
      expect(page).to have_content("#{@pet1.age}")
      expect(page).to have_content("#{@pet1.sex}")
      expect(page).to have_content("#{@shelter1.name}")
    end
  end
end
