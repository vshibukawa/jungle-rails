class ReviewsController < ApplicationController

  before_filter :check_current_user, :only => [:create, :destroy]
  before_filter :check_user, :only => [:destroy]

  def create
    @product = Product.find params[:product_id]
    @review  = @product.review.new review_params
    @review.user_id = current_user.id
    @review.save

    redirect_to @product
  end

  def destroy
    Review.find(params[:id]).destroy
    redirect_to product_path(params[:product_id])
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

    def check_current_user
      if !current_user
        flash[:danger] = "You must be logged in"
        redirect_to Product.find params[:product_id]
      end
    end

    def check_user
      review = Review.find(params[:id])
      if review && review.user_id != current_user.id
        flash[:danger] = "You cannot delete/save this review. Please login"
        redirect_to Product.find params[:product_id]
      end
    end
end
