class CourseSubjectsController < ApplicationController
  before_action :logged_in_user, :find_course_subject, 
    :started_subject?, :course_of_trainee?, only: :show

  def show
    @course = @course_subject.course
    @subject = @course_subject.subject
  end

  private
  def find_course_subject
    @course_subject = CourseSubject.find_by id: params[:id]
    if @course_subject.nil?
      flash[:danger] = t "subjects.not_found"
      redirect_to root_path
    end
  end

  def started_subject?
    unless @course_subject.started?
      redirect_to :back
      flash[:danger] = t "subjects.not_started"
    end
  end
  
  def course_of_trainee?
    unless current_user.courses.include? @course_subject.course
      redirect_to :back
      flash[:danger] = t "courses.not_in_course"
    end
  end
end
