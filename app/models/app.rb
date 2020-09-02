class App < ApplicationRecord
  has_many :pet_apps
  has_many :pets, through: :pet_apps

  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip,
                        :phone_number,
                        :description,
                        :status

  def status_to_approved
   self.status = "Approved"
   self.save
  end

  def status_to_unapproved
   self.status = "Unapproved"
   self.save
  end
end
