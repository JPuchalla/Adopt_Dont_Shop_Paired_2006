require "rails_helper.rb"

RSpec.describe Review, type: :model do
  describe "relationships" do
    it {should belong_to :shelter}
  end

  describe "validations" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :rating }
    it { should validate_presence_of :content }
    it { should validate_presence_of :image }
  end
end
