class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[index, show]
  
  def index
    if current_user.admin
      @users = User.all
    else
      redirect_to root_path  
    end
  end
  
  def show
    
    @categories = Category.all
    @user = User.find(params[:id])
    @q = @user.reviews.ransack(params[:q])
    @reviews = @q.result(distinct: true)
    

    @showUserInfo = @user.nick + ' (' + t('profile.likesCount') + @user.countUserLikes + ')'
  end


end
