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
  end
end
