class Admin::SubjectsController < ApplicationController
  before_action :logged_in_user
  before_action :verify_admin
  before_action :find_subject, except: [:new, :create, :index]

  def new
    @subject = Subject.new
    Settings.default_number_of_tasks.times {@subject.tasks.build}
  end

  def create
    @subject = Subject.new subject_params
    if @subject.save
      flash[:success] = t "subjects.create_success"
      redirect_to admin_subject_path @subject
    else
      render :new
    end
  end

  def show
  end

  def index
    @subjects = Subject.all
  end

  def edit
  end

  def update
    if @subject.update subject_params
      flash[:success] = t "subjects.edit_success"
      redirect_to admin_subject_path @subject
    else
      render :edit
    end
  end

  def destroy
    if @subject.destroy
      flash[:success] = t "flash.delete_success"
    else
      flash[:danger] = t "flash.delete_fail"
    end
    redirect_to admin_subjects_path
  end

  private
  def subject_params
    params.require(:subject).permit :title, :description,
      tasks_attributes: [:id, :title, :description, :_destroy]
  end

  def find_subject
    @subject = Subject.find_by id: params[:id]
    unless @subject
      flash[:danger] = t "flash.subject_empty"
      redirect_to root_url
    end
  end
end
