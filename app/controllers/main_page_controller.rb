class MainPageController < ApplicationController
  before_action :most_rated
  def index
    @categories = Category.all
    
    @reviewsLast = Review.last(3).reverse
  end

  private
  def most_rated
  
    @reviews = Review.all
    @reviews.each do |review|
     calculateAverageRating(review)
    end
  end

end
