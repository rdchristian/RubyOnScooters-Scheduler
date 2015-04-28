class MasterPageController < ApplicationController
before_filter :authenticate_user!, :authenticate_admin!, :on => :create

  def new
    @users = User.all
    @events = Event.all
  end

  def create
    @users = User.all
    @events = Event.all
    if current_user.is_admin?
      render 'new'
    else
      redirect_to root_path
    end
  end

  def change_schedule_variable
    regular_days = params[:regular].to_i
    staff_days = params[:staff].to_i
    regular_box = params[:regular_box]
    staff_box = params[:staff_box]

    if regular_box
      Rails.application.config.REGULAR_SCHEDULE_DAYS = -1
    elsif regular_days > 0
      Rails.application.config.REGULAR_SCHEDULE_DAYS = regular_days
    end

    if staff_box
      Rails.application.config.STAFF_SCHEDULE_DAYS = -1
    elsif staff_days > 0
      Rails.application.config.STAFF_SCHEDULE_DAYS = staff_days
    end

    redirect_to admin_path
  end

end
