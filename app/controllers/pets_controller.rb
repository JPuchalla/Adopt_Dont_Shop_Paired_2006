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
    @pet = Pet.find(params[:id])
    @pet.update(pet_params)
    if @pet.save
      redirect_to "/pets/#{@pet.id}"
    else
      flash[:notice] = "Fill in all fields before submission."
      render :edit
    end
  end

  def destroy
    pet = Pet.find(params[:id])
    favorites.remove_pet(params[:id])
    pet.pet_apps.each do |app|
      app.destroy!
    end
    pet.destroy
    redirect_to "/pets"
  end

  private

  def pet_params
    params.permit(:image, :name, :description, :age, :sex)
  end
end
