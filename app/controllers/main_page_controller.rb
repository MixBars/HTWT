class MainPageController < ApplicationController
  def index
    @categories = Category.all
    
    @reviewsLast = Review.last(3).reverse
  end
end
