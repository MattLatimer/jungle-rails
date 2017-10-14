class ReviewsController < LoggedInController
  before_action do
    @product = Product.find(params[:product_id])
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

  def destroy
    review = Review.find(params[:id])
    if review.user_id == current_user.id
      review.destroy
    end
    redirect_to @product    
  end

  private
  def review_params
    params.require(:review).permit(:description, :rating)
  end
end
