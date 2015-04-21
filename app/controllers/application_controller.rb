class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  def authenticate_user!
	  if not logged_in?
	  	redirect_to login_path
	  end
  end
	
  helper_method :is_admin? # To make it accessible in the views
  def is_admin?
    false
  end

  helper_method :footlog
  def footlog(thing)
    flash[:log] || flash[:log] = []
    flash[:log] << thing
  end

end
