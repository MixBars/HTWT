class UserRatingsController < ApplicationController
 before_action :find_review

 def create
  @review.user_rating.create(user_id: current_user.id, score: params[:score])
  redirect_to review_path(@review)
 end

 def destroy
  @review.user_rating.where(user_id: current_user.id).destroy_all
  redirect_to review_path(@review)
 end 

private 
 def find_review
  @review = Review.find(params[:review_id])
end


end