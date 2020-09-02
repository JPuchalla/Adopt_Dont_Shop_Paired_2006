class AppsController < ApplicationController
  def new
    @pets = favorites.favorite_pets
  end

  def create
    selected_pets = params.keys.find_all { |key| key.include?("select-") }
    application = App.create(application_params)
    if application.save
      application.pets << selected_pets.map { |pet| Pet.find(params[pet].to_i) }
      application.pets.each do |pet|
        PetApp.create(pet_id: pet.id, app_id: application.id )
        favorites.remove_pet(pet.id)
      end
      redirect_to "/favorites"
      flash[:notice] = "Application successfully submitted!"
    else
      redirect_to "/apps/new"
      flash[:notice] = "Please ensure all form fields completed for submission."
    end
  end

  def show
    @application = App.find(params[:id])
  end

  private

  def application_params
    params.permit(:name, :address, :city, :state, :zip, :phone_number, :description)
  end
end
