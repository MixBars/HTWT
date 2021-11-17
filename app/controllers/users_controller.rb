class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[index, show]
  
  def index
    if current_user.admin
      @users = User.all
    else
      redirect_to root_path  
    end
  end

  def sort
  
  end
  
  def show
    @categories = Category.all

    @user=User.find(params[:id])
    
    @reviews = Review.where(authorEmail: @user.email)
    

    @showUserInfo = getUserNick(@user) + ' (' + countUserLikes(@user) + ' likes)'
    
  end

  private

  
  def countUserLikes(user)
    @reviews = Review.where(authorEmail: user.email)
    sum = 0
    @reviews.each do |review|
      sum += review.likes.count
    end
    return sum.to_s
  end

  def getUserNick(user)
    user.email[0..user.email.index('@')-1]
  end

end
