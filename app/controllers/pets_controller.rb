class PetsController < ApplicationController

  def index
    @pets = Pet.all
    favorites = Favorites.new(session[:favorites])
  end

  def show
    @pet = Pet.find(params[:id])
    @approved_apps = @pet.apps.where({status: "Approved"})
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    pet = Pet.find(params[:id])
    pet.update(pet_params)
    redirect_to "/pets/#{pet.id}"
  end

  def destroy
    pet = Pet.find(params[:id])
    pet.destroy
    redirect_to "/pets"
  end

  private

  def pet_params
    params.permit(:image, :name, :description, :age, :sex)
  end
end
