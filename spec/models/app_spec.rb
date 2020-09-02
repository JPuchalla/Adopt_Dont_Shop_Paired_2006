require "rails_helper.rb"

RSpec.describe App, type: :model do
  describe "relationships" do
    it {should have_many :pet_apps}
    it {should have_many(:pets).through(:pet_apps)}
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
    it { should validate_presence_of :phone_number }
    it { should validate_presence_of :description }
    it { should validate_presence_of :status }
  end

  describe "methods" do
    it "#change_status" do
      shelter1 = Shelter.create!(name: "Paw Friends", address: "12345 NW. 32 St.", city: "Denver", state: "CO", zip: "80008")
      pet1 = Pet.create!(image: "https://pyxis.nymag.com/v1/imgs/0c2/a83/4cfc644e76854d6cfe92f58219d2273a25-14-courage-the-cowardly-dog.rsquare.w700.jpg",name: "Courage",description: "Scared of everything except squirrels.", age: 2, sex: "M", shelter_id: shelter1.id)
      application1 = App.create!(name: "Bob Guy", address: "3888 Octavius st", city: "Denver", state: "Colorado", zip: "22212", phone_number: "7032220203", description: "Have a big yard and a brush.")
      PetApp.create!(pet_id: pet1.id, app_id: application1.id)

      expect(application1.status).to eq("Unapproved")
      application1.status_to_approved
      expect(application1.status).to eq("Approved")
      application1.status_to_unapproved
      expect(application1.status).to eq("Unapproved")
    end
  end
end
