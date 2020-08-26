class ReviewsController < ApplicationController
  def create
    @shelter = Shelter.find(params[:id])
  end
end
