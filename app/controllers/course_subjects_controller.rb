class CourseSubjectsController < ApplicationController
  before_action :logged_in_user, :find_course_subject, 
    :started_subject?, :course_of_trainee?, only: :show
  before_action :logged_in_user, :find_user_subject, only: :update
  before_action :finished_task?, :verify_trainee, only: :update

  def show
    @course = @course_subject.course
    @subject = @course_subject.subject
  end

  def edit
  end

  def update
    if UserTask.create user_id: current_user.id, task_id: params[:task_id],
      user_subject_id: @user_subject.id
      flash[:success] = t "tasks.finish_success"
    else
      flash[:danger] = t "tasks.finish_fail"
    end
    redirect_to user_course_course_subject_path
  end

  private
  def find_user_subject
    @user_subject = UserSubject.find_by user_id: params[:user_id]
    if @user_subject.nil?
      flash[:danger] = t "subjects.not_found"
      redirect_to user_course_course_subject_path
    end
  end

  def finished_task?
    if UserTask.find_by user_id: current_user.id, task_id: params[:task_id],
      user_subject_id: @user_subject.id
      flash[:danger] = t "tasks.permission"
      redirect_to user_course_course_subject_path
    end
  end

  def find_course_subject
    @course_subject = CourseSubject.find_by id: params[:id]
    if @course_subject.nil?
      flash[:danger] = t "subjects.not_found"
      redirect_to courses_path
    end
  end

  def started_subject?
    unless @course_subject.started?
      flash[:danger] = t "subjects.not_started"
      redirect_to :back
    end
  end
  
  def course_of_trainee?
    unless current_user.courses.include? @course_subject.course
      flash[:danger] = t "courses.not_in_course"
      redirect_to root_url 
    end
  end
end
