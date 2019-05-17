class ProductsController < ApplicationController

  def index
    @products = Product.all.order(created_at: :desc)
  end

  def show
    @review = Review.new
    @product = Product.find params[:id]
    @reviews = Review.where(product_id: @product.id).order(created_at: :desc)
    # byebug
    # @users = User.find(@reviews) if @reviews.size
    # filtered = @users.collect{ |user| user if user.id == 2 }
    # filtered[0].first_name
  end


end
