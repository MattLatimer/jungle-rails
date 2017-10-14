class ReviewsController < ApplicationController

  before_action do
    @product = Product.find(params[:product_id])
    redirect_to @product unless current_user
  end

  def create
    @review = Review.new(review_params)
    @review.product = @product
    @review.user = current_user

    if @review.save
      redirect_to @product
    else
      render template: 'products/show'
    end
  end

  private
  def review_params
    params.require(:review).permit(:description, :rating)
  end
end