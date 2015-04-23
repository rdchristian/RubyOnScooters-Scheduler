class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  protected

    include SessionsHelper

    def authenticate_user!
      if not logged_in?
        redirect_to login_path
      end
    end
    
    helper_method :is_admin? # To make it accessible in the views
    def is_admin?
      current_user.is_admin?
    end

    helper_method :footlog
    def footlog(*thing)
      thing.each do |t|
        flash[:log] || flash[:log] = []
        flash[:log] << t
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

