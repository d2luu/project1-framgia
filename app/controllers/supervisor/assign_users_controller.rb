class Supervisor::AssignUsersController < ApplicationController
  before_action :logged_in_user, :verify_supervisor, :verify_editable_course

  def edit
    @trainees = User.trainee.availble_user Course.statuses[:started]
    @supervisors = User.supervisor
  end

  def update
    if @course.update_attributes user_course_params
      flash[:success] = t "assign_users.success"
    else
      flash.now[:danger] = t "assign_users.fail"
    end
    redirect_to supervisor_course_path @course
  end

  private
  def user_course_params
    params.require(:course).permit user_ids: []
  end

  def verify_editable_course
    @course = Course.find_by id: params[:id]
    if @course.nil? or @course.started? or @course.finished?
      flash[:danger] = t "courses.cannot_edit"
      redirect_to :back
    end
  end
end
