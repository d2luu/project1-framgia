class Admin::AssignSupervisorsController < ApplicationController
  before_action :logged_in_user, :verify_admin, :verify_owned_course

  def edit
    @supervisors = User.supervisor
  end

  def update
    if @course.add_owner params[:course][:owner_id]
      flash[:success] = t "assign_users.success"
    else
      flash[:danger] = t "assign_users.fail"
    end
    redirect_to admin_course_path @course
  end

  private
  def verify_owned_course
    @course = Course.find_by id: params[:id]
    if @course.nil?
      flash[:danger] = t "courses.empty"
      redirect_to root_path
    else
      if @course.owner_id.present?
        flash[:danger] = t "assign_users.owned"
        redirect_to admin_course_path @course
      end
    end
  end
end
