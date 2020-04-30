class Admin::DashboardController < ApplicationController
   before_filter :authorize
   
  def show
  end

  def product_counter
   @products = Product.all.count
  end
  helper_method :product_counter

  def category_counter
   @categories = Category.all.count
  end
  helper_method :category_counter
end
