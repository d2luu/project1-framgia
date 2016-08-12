class CoursesController < ApplicationController
  before_action :logged_in_user

  def index
    @courses = current_user.courses
  end

  def show
    @course = Course.find_by id: params[:id]
    if @course.nil?
      flash.now[:danger] = t "flash.course_not_found"
      redirect_to root_path   
    else
      @supervisors = User.user_in_course @course.id, User.roles[:supervisor]
      @trainees = User.user_in_course @course.id, User.roles[:trainee]
      if @course.incoming?
        flash[:danger] = t "flash.course_not_started"
        redirect_to courses_path
      end
    end
  end
end
