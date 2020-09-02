class Shelter < ApplicationRecord
  has_many :pets
  has_many :reviews

  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip

  def pets_pending?
  pets_pend = self.pets.where({status: "Pending"})
  !pets_pend.empty?
  end
end
