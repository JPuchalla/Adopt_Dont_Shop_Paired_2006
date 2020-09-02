class Shelter < ApplicationRecord
  has_many :pets, dependent: :delete_all
  has_many :reviews, dependent: :delete_all

  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip

  def pets_pending?
    pets_pend = self.pets.where({status: "Pending"})
    !pets_pend.empty?
  end

  def apps_on_file
    self.pets.map do |pet|
      pet.apps
    end
  end

  def pet_count
    self.pets.count
  end


end
