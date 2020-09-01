require "rails_helper.rb"

RSpec.describe Pet, type: :model do
  describe "relationships" do
    it {should belong_to :shelter}
    it {should have_many :pet_apps}
    it {should have_many(:apps).through(:pet_apps)}
  end

  describe "validations" do
    it { should validate_presence_of :image }
    it { should validate_presence_of :name }
    it { should validate_presence_of :age }
    it { should validate_presence_of :sex }
  end

  describe "methods" do
    it "#change_status" do
      shelter1 = Shelter.create!(name: "Paw Friends", address: "12345 NW. 32 St.", city: "Denver", state: "CO", zip: "80008")

      pet1 = Pet.create!(image: "https://pyxis.nymag.com/v1/imgs/0c2/a83/4cfc644e76854d6cfe92f58219d2273a25-14-courage-the-cowardly-dog.rsquare.w700.jpg",name: "Courage",description: "Scared of everything except squirrels.", age: 2, sex: "M", shelter_id: shelter1.id)

      expect(pet1.status).to eq("Adoptable")

      pet1.status_to_pending

      expect(pet1.status).to eq("Pending")

      pet1.status_to_adoptable

      expect(pet1.status).to eq("Adoptable")
    end
  end
end
