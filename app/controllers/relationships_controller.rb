class RelationshipsController < ApplicationController
  before_action :logged_in_user
  before_action -> {find_user params[:followed_id]}, only: [:create, :destroy]
  before_action -> {find_user params[:user_id]}, only: :index
  
  def index
    @title = t "relationship.#{params[:action_type]}"
    @users = @user.send params[:action_type]
  end

  def create
    if current_user.following? @user
      flash[:danger] = t "relationship.followed"
    else
      current_user.follow @user
      flash.clear
    end
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end  
  end

  def destroy
    if Relationship.find_by(id: params[:id]).nil?
      flash[:danger] = t "relationship.unfollowed"
    else
      @user = Relationship.find_by(id: params[:id]).followed
      current_user.unfollow @user
      flash.clear
    end
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end

  private
  def find_user user_id
    @user = User.find_by id: user_id
    unless @user.present?
      flash[:danger] = t "flash.detele_user_fail"
      redirect_to root_url
    end
  end
end
