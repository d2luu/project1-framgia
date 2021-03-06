module SessionsHelper
  def log_in user
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find_by id: session[:user_id]
  end

  def store_location
    session[:forwarding_url] = request.url if request.get?
  end
  
  def logged_in?
    current_user.present?
  end

  def log_out
    session.delete :user_id
    @current_user = nil
  end

  def is_owner? supervisor, course
    supervisor.user == current_user or
      supervisor.user_id == course.owner_id
  end

  def finished_task? task
    current_user.user_tasks.exists? task_id: task.id
  end
end
