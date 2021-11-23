class SearchController < ApplicationController
 def search
  if params[:q].nil?
    @reviews = []
  else
    @reviews = Review.search params[:q]
  end
 end
end
