class ReviewsController < ApplicationController

  def create
    @product = Product.find params[:product_id]
    @review  = @product.review.new review_params
    # byebug
    @review.user_id = current_user.id
    @review.save

    redirect_to @product
  end

  private

    def review_params
      params.require(:review).permit(
        :description,
        :rating,
        :product_id,
        :user_id,
      )
    end

end
