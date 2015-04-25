class SessionsController < ApplicationController
  include SessionsHelper

  def new
  end

  def create
  	user = User.find_by(email: params[:session][:email].downcase)
  	if user && user.authenticate(params[:session][:password])
  		login user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to user
    elsif user && !user.is_activated?
      flash.now[:danger] = 'Your account has not yet been activated'
      render 'new'
  	elsif !user || (user && !user.authenticate(params[:session][:password]))
  		flash.now[:danger] = 'Invalid email/password combination'
  		render 'new'
  	end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
