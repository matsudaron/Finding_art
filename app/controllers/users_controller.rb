class UsersController < ApplicationController
  before_action :require_login, except: [:new, :create]
  
  def new
    @user = User.new
  end
      
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path, success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :new, status: :unprocessable_entity
    end
  end
      
  private
      
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :last_name, :first_name, :avatar, :avatar_cache)
  end
end
