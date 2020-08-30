class App < ApplicationRecord
  has_many :pet_apps
  has_many :pets, through: :pet_apps

  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip,
                        :phone_number,
                        :description
end
