class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  def authenticate_user!
	  #if not logged_in? && request.env['PATH_INFO'] !~ /.*\/users\/new/
    if not logged_in?
	  	redirect_to login_path
	  end
  end

  def authenticate_admin!
    if not current_user.is_admin?
      redirect_to root_path
    end
  end

  def authenticate_activation!
    if !current_user.is_activated?
      log_out
      redirect_to login_path
    end
  end
	
end
