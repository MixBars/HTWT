class MainPageController < ApplicationController
  def index
    @reviewsLast = Review.last(3).reverse
  end
end
