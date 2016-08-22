class Supervisor::UserCoursesController < ApplicationController
  before_action :logged_in_user, :verify_supervisor, :find_user_course

  def destroy
    if current_user.id != @user_course.user_id and 
      @user_course.user_id != @course.owner_id and 
      @user_course.destroy
      flash[:success] =  t "flash.removed_user"
    else
      flash[:danger] = t "flash.remove_user_failed"
    end
    redirect_to supervisor_course_path @course
  end

  private
  def find_user_course
    @user_course = UserCourse.find_by id: params[:id]
    @course = Course.find_by id: @user_course.course_id
  end
end
