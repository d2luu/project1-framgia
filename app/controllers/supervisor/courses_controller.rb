class Supervisor::CoursesController < ApplicationController
  before_action :logged_in_user
  before_action :verify_supervisor
  before_action :find_course, :verify_permission, only: :show

  def index
    @courses = Course.paginate page: params[:page], 
      per_page: Settings.default_items_per_page
  end

  def show
    @user_courses = @course.user_courses
    @supervisors = @user_courses.supervisors
    @trainees = @user_courses.trainees
  end

  private
  def find_course
    @course = Course.find_by id: params[:id]
    if @course.nil?
      flash[:danger] = t "courses.empty"
      redirect_to root_url
    end
  end

  def verify_permission
    unless UserCourse.find_by user_id: current_user.id,
      course_id: @course.id
      flash[:danger] = t "courses.not_in_course"
      redirect_to supervisor_courses_path
    end
  end
end
