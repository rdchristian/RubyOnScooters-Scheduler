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
      current_user and current_user.is_admin?
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
  def events_to_calendar_format(results)
  styles = %w( important warning info success inverse special ).map{ |s| 'event-' + s }
  recurring_styles = {}
  results.each_with_index.collect do |result, i|
    event, time = result
    if event.recurrence.present?
      ending = time + event.recurrence.duration
      recurring_styles[event.id] ||= styles[i % styles.length]
      style = recurring_styles[event.id]
    else
      ending = event.ending
      style = styles[i % styles.length]
    end
    {
      id:      event.id,
      title:   event.title,
      url:     user_event_path(event.creator, event),
      start:   time.to_datetime.strftime('%Q'),
      'end':   ending.to_datetime.strftime('%Q'),
      'class': style
    }
  end
end

end

