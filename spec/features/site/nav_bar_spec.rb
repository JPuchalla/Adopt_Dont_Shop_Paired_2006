require 'rails_helper'
describe "layouts/application.html.erb" do
  it "should have navbar links to home, shelters, and pets." do
    visit "/shelters"
    within(".navbar") do
      expect(page).to have_link("Home", href: "/")
      expect(page).to have_link("Pet Index", href: "/pets")
      expect(page).to have_link("Shelter Index", href: "/shelters")
    end
  end
end
