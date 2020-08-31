class FavoritesController < ApplicationController
  def update
    pet = Pet.find(params[:pet_id])
    favorites = Favorites.new(session[:favorites])
    favorites.add_pet(pet.id)
    session[:favorites] = favorites.pets
    flash[:notice] = "You have added #{pet.name} to your favorites."
    redirect_to "/pets/#{pet.id}"
  end

  def index
    app_pets = PetApp.pluck(:pet_id)
    @pets = app_pets.map {|pet_id| Pet.find(pet_id)}
  end

  def show_destroy
    pet = Pet.find(params[:pet_id])
    favorites = Favorites.new(session[:favorites])
    favorites.remove_pet(pet.id)
    session[:favorites] = favorites.pets
    flash[:notice] = "#{pet.name} has been removed from your favorites."
    redirect_to "/pets/#{pet.id}"
  end

  def index_destroy
    pet = Pet.find(params[:pet_id])
    favorites = Favorites.new(session[:favorites])
    favorites.remove_pet(pet.id)
    session[:favorites] = favorites.pets
    redirect_to "/favorites"
  end

  def destroy_all
    favorites = Favorites.new(session[:favorites])
    favorites.pets.clear
    session[:favorites] = favorites.pets
    redirect_to "/favorites"
  end
end
