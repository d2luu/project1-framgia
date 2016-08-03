class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :find_user, only: [:show, :edit, :update]
  before_action :correct_user, only: [:edit, :update] 

  def show
  end
  
  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] =  t "flash.user_updated"
      redirect_to @user
    else
      render :edit
    end
  end

  private
  def find_user
    @user = User.find_by id: params[:id]
    redirect_to root_url unless @user
  end

  def user_params
    params.require(:user).permit :password, 
      :password_confirmation
  end
    
  def correct_user
    redirect_to root_url unless @user.current_user? current_user 
  end
end
