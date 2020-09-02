class PetAppsController < ApplicationController

  def index
    @pet = Pet.find(params[:id])
    pet_apps = PetApp.where(pet_id: params[:id])
    @current_applicants = pet_apps.map {|app| App.find(app.app_id)}
  end

  def approve
    pet = Pet.find(params[:pet_id])
    app = App.find(params[:app_id])
    pet.status_to_pending
    app.status_to_approved
    redirect_to "/pets/#{pet.id}"
  end

  def revoke
    pet = Pet.find(params[:pet_id])
    app = App.find(params[:app_id])
    pet.status_to_adoptable
    app.status_to_unapproved
    redirect_to "/apps/#{app.id}"
  end
end
