class Review < ApplicationRecord
  belongs_to :shelter

  validates_presence_of :title,
                        :rating,
                        :content

  validates_presence_of :image, allow_nil: true
  # before_save :check_image
  #
  # def check_image
  #   if self.image.empty?
  #     self.image = nil
  #   end
  # end
end
