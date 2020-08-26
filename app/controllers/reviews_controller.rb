class ReviewsController < ApplicationController
  def new
    @shelter = Shelter.find(params[:id])
  end

  def create
    @shelter = Shelter.find(params[:id])
    review = @shelter.reviews.create(create_review_params)

    if review.save
      redirect_to "/shelters/#{@shelter.id}"
    else
      flash[:notice] = "Please enter title, rating, and content in order to submit a review."
      redirect_to "/shelters/#{@shelter.id}/reviews/new"
    end
  end

  private

  def review_params
    params.permit(:title, :rating, :content, :image)
  end

  def create_review_params
    c = review_params.to_hash
    c["image"] = nil if c["image"].empty?
    c
  end
end
