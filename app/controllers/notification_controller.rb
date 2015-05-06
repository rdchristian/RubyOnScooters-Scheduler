class NotificationsController < ApplicationController
 
  skip_before_action :verify_authenticity_token
 
  #Text to remind people to return what they borrowed
  def check_in_reminder(user)
  	client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
	message = client.messages.create from: Rails.application.config.TWILIO_PHONE, to: user.phone, body: 'Fellowship Church: Please check in what you items you used for your recent event.'  
	Rails.application.config.  
	redirect_to admin_path
  end
 
end