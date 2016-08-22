class Supervisor::ActiveSubjectsController < ApplicationController
  before_action :logged_in_user, :verify_supervisor, :verify_actived_course
   
  def update
    if @subject.update_attributes status: params[:status]
      flash[:success] = t "flash.subject_started"
    else
      flash[:danger] = t "flash.subject_failed"
    end
    redirect_to :back
  end

  private
  def verify_actived_course
    @course = Course.find_by id: params[:course_id]
    unless @course.started?
      flash[:danger] = t "flash.course_not_actived"
      redirect_to [:supervisor, @course]
    end
  end

  def find_subject
    @subject = CourseSubject.find_by id: params[:course_subject_id]
    if @subject.nil?
      flash[:danger] = t "subjects.not_found"
      redirect_to :back
    end
  end
end
