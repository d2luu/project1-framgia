class CoursesController < ApplicationController
  before_action :logged_in_user
  before_action :find_course, :course_of_trainee?, only: :show

  def index
    @courses = current_user.courses
  end

  def show      
    @supervisors = @course.users.supervisor
    @trainees = @course.users.trainee
    if @course.incoming?
      flash[:danger] = t "flash.course_not_started"
      redirect_to courses_path
    end
  end

  private
  def find_course
    @course = Course.find_by id: params[:id]
    if @course.nil?
      flash.now[:danger] = t "flash.course_not_found"
      redirect_to root_path 
    end
  end

  def course_of_trainee?
    redirect_to root_url unless current_user.courses.include? @course
  end
end
