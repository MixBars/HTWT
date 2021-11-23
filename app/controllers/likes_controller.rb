class LikesController < ApplicationController
 before_action :find_review, :userLikeOnReview 
 
 def create
  @review.likes.create(user_id: current_user.id)
  redirect_to review_path(@review)
 end  
  

 def destroy
  @like.destroy_all
  redirect_to review_path(@review)
 end 


  private  
  
  def userLikeOnReview
   if user_signed_in?
    @like = Like.where(user_id: current_user.id, review_id: params[:review_id])
   end
  end

  def find_review
    @review = Review.find(params[:review_id])
  end
end
