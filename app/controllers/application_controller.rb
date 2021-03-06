class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  private
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t "login_warning"
      redirect_to login_url
    end
  end

  def verify_admin
    unless current_user.admin?
      flash[:danger] = t "flash.not_admin"
      redirect_to root_path
    end 
  end

  def verify_supervisor
    unless current_user.supervisor?
      flash[:danger] = t "flash.not_supervisor"
      redirect_to root_path
    end 
  end

  def verify_trainee
    unless current_user.trainee?
      flash[:danger] = t "flash.not_supervisor"
      redirect_to root_path
    end 
  end
end
