class LikesController < ApplicationController
 before_action :find_review, :userLikeOnReview 
 
 def create
  if @like.exists?
   flash[:notice] = "You can't like more than once"
  else
   @review.likes.create(user_id: current_user.id)
  end
  redirect_to review_path(@review)
 end  
  

 def destroy
  if user_signed_in?
    if !@like.exists?
      flash[:notice] = "You can't unlike more than once"
    else
    @like.destroy_all
    end
   redirect_to review_path(@review)
  end
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
