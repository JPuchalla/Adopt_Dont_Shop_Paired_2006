class ReviewsController < ApplicationController
  def new
    @shelter = Shelter.find(params[:id])
    # render :new
  end

  def create
    @shelter = Shelter.find(params[:id])
    review = @shelter.reviews.create(create_update_review_params)
    if review.save
      redirect_to "/shelters/#{@shelter.id}"
    else
      flash[:notice] = "Please enter title, rating, and content in order to submit a review."
      render :new
    end
  end

  def edit
    @shelter_id = params[:id]
    @review_id= params[:review_id]
    @review = Review.find(params[:review_id])
  end

  def update
    @review = Review.find(params[:review_id])
    shelter = Shelter.find(params[:id])
    @shelter_id = shelter.id
    @review_id = @review.id
    if @review.update(create_update_review_params)
      redirect_to "/shelters/#{params[:id]}"
    else
      flash[:notice] = "Title, rating, and content are required in order to edit review."
      render :edit
    end
  end

  def destroy
    review = Review.find(params[:review_id])
    shelter = Shelter.find(params[:id])
    review.destroy
    redirect_to "/shelters/#{shelter.id}"
  end

  private

  def review_params
    params.permit(:title, :rating, :content, :image)
  end

  def create_update_review_params
    rp = review_params.to_hash
    rp["image"] = nil if rp["image"].empty?
    rp
  end
end
