class Admin::CoursesController < ApplicationController
  before_action :logged_in_user
  before_action :verify_admin
  before_action :find_course, except: [:index, :new, :create]
  before_action :load_subjects, only: [:new, :edit]

  def index
    @courses = Course.all
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new course_params
    if @course.save
      flash[:success] = t "courses.created"
      redirect_to admin_courses_path
    else
      load_subjects
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @course.update course_params
      flash[:success] = t "courses.updated"
      redirect_to admin_course_path @course
    else
      load_subjects
      render :edit
    end
  end

  def destroy
    if @course.destroy
      flash[:success] = t "courses.deleted"
    else
      flash[:danger] = t "courses.empty"
    end
    redirect_to admin_courses_path
  end

  private
  def course_params
    params.require(:course).permit :title, :description, subject_ids: []
  end

  def find_course
    @course = Course.find_by id: params[:id]
    if @course.nil?
      flash[:danger] = t "courses.empty"
      redirect_to root_url
    end
  end

  def load_subjects
    @subjects = Subject.all
  end
end
