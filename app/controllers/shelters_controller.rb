class SheltersController < ApplicationController
  def index
    @shelters = Shelter.all
  end

  def show
    @shelter = Shelter.find(params[:id])
  end

  def new
  end

  def create
    shelter = Shelter.create(shelter_params)
    if shelter.save
      redirect_to "/shelters"
    else
      flash[:notice] = "Please fill out all fields before submission."
      render :new
    end
  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def update
    @shelter = Shelter.find(params[:id])
    @shelter.update(shelter_params)
    if @shelter.save
      redirect_to "/shelters/#{@shelter.id}"
    else
      flash[:notice] = "Please fill out all fields before submission."
      render :edit
    end
  end

  def destroy
    shelter = Shelter.find(params[:id])
      shelter.pets.each do |pet|
        pet.pet_apps.each do |app|
          app.destroy!
        end
      end
    shelter.destroy
    redirect_to "/shelters"
  end

  private

  def shelter_params
    params.permit(:name, :address, :city, :state, :zip)
  end
end
