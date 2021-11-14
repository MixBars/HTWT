class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[index]
  
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
    @user=User.find(params[:id])
    
    @reviews = Review.where(authorEmail: @user.email).sort_by{|e| e[params[:sort]]}

     
    
  end
end
