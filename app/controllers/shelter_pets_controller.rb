class ShelterPetsController < ApplicationController

  def index
    @shelter = Shelter.find(params[:shelter_id])
  end

  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    @shelter = Shelter.find(params[:shelter_id])
    @shelter.pets.create(pet_params)
    if @shelter.save
      redirect_to "/shelters/#{@shelter.id}/pets"
    else
      flash[:notice] = "Fill in all fields before submission."
      render :new
    end
  end

  private

  def pet_params
    params.permit(:image, :name, :description, :age, :sex)
  end
end
