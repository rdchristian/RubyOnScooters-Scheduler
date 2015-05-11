class NotificationsController < ApplicationController
 
  skip_before_action :verify_authenticity_token
 
  #Text to remind people to return what they borrowed
  def check_in_reminder
  	@event = Event.find(params[:id])
  	client = Twilio::REST::Client.new "ACacbc302876de38b8d7c08fc2ae0536b1", "c0e07871ca06a2ab7c2864aeb0f86c61"
	message = client.messages.create from: Rails.application.config.TWILIO_PHONE, to: @event.creator.phone, body: "Fellowship Church: Please check in what items you used for your event #{@event.title}." 
	flash[:notice] = "Messages Sent"
	redirect_to admin_path
  end
 
end