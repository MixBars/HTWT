class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[index]
  
  def index
    if current_user.admin
      @users = User.all
    else
      redirect_to root_path  
    end
  end

  def show
    @user=User.find(params[:id])
  end
end
