class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :pet_apps
  has_many :apps, through: :pet_apps

  validates_presence_of :image,
                        :name,
                        :age,
                        :sex,
                        :status

  def status_to_pending
   self.status = "Pending"
   self.save
  end

  def status_to_adoptable
   self.status = "Adoptable"
   self.save
  end
end
