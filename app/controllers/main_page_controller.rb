class MainPageController < ApplicationController
  
  def index
    @categories = Category.all
    @reviewsRated = Review.all.sort_by{|h| h.user_rating.average('score').to_d}.last(3).reverse
    @reviewsLast = Review.last(3).reverse
    
  end

  

end
