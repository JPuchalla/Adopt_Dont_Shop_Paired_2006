class PetAppsController < ApplicationController

  def index
    @pet = Pet.find(params[:id])
    pet_apps = PetApp.where(pet_id: params[:id])
    @current_applicants = pet_apps.map {|app| App.find(app.app_id)}
  end
end
