class Admin::UsersController < ApplicationController
  before_action :logged_in_user
  before_action :verify_admin
  before_action :find_user, only: [:show, :destroy]
  before_action :get_role, only: [:new]

  def new
    @user = User.new
  end

  def show
  end

  def index
    @trainees = User.trainee
    @supervisors = User.supervisor
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "flash.user_created"
      redirect_to admin_users_path
    else
      get_role
      flash[:danger] = t "flash.user_notcreated"
      render :new
    end
  end

  def destroy
    @user.delete
    flash[:danger] = t "flash.delete_user"
    redirect_to admin_users_path
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :role,
      :password, :password_confirmation
  end

  def get_role
    @roles = User.roles.keys.reject {|a| a == "admin"}
  end

  def find_user
    @user = User.find_by id: params[:id]
    if @user.nil?
      flash[:danger] = t "flash.detele_user_fail"
      redirect_to root_path
    end
  end
end
