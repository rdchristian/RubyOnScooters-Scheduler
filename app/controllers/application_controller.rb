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
      if not Rails.env.production?
        thing.each do |t|
          flash[:log] || flash[:log] = []
          flash[:log] << t
        end
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

  helper_method :events_to_calendar_format
  def events_to_calendar_format(events)
  styles = %w( important warning info success inverse special ).map{ |s| 'event-' + s }
  events.each_with_index.collect do |event, i|
    {
      id:      event.id,
      title:   event.title,
      url:     user_event_path(event.creator, event),
      start:   event.start.to_datetime.strftime('%Q'),
      'end':   event.ending.to_datetime.strftime('%Q'),
      'class': styles[i % styles.length]
    }
  end
end

end

