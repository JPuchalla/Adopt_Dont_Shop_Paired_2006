class AppsController < ApplicationController
  def new
    @pets = favorites.favorite_pets
  end

  def create
    selected_pets = params.keys.find_all { |key| key.include?("select-") }
    application = App.create(applications_params)
    application.pets << selected_pets.map { |pet| Pet.find(params[pet].to_i) }
    application.pets.each do |pet|
      pet_app = PetApp.create(pet_id: pet.id, app_id: application.id )
      favorites.remove_pet(pet.id)
    end
    redirect_to "/favorites"
    flash[:notice] = "Application successfully submitted!"
  end

  private

  def applications_params
    params.permit(:name, :address, :city, :state, :zip, :phone_number, :description)
  end
end
