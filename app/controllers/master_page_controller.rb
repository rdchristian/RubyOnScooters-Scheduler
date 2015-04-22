class MasterPageController < ApplicationController
before_filter :authenticate_user!, :authenticate_admin!, :on => :create

  def new
    @users = User.all
  end

  def create
    @users = User.all
    if current_user.is_admin?
      render 'new'
    else
      redirect_to root_path
    end
  end

  def activate_user (user)
    user.activate
  end

  helper_method:activate_user

end
