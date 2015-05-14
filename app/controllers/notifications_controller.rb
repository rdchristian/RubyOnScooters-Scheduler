class NotificationsController < ApplicationController
 
  skip_before_action :verify_authenticity_token
 
  #Text to remind people to return what they borrowed
  def check_in_reminder
  	@event = Event.find(params[:id])
  	client = Twilio::REST::Client.new "ACacbc302876de38b8d7c08fc2ae0536b1", "c0e07871ca06a2ab7c2864aeb0f86c61"
	message = client.messages.create from: Rails.application.config.TWILIO_PHONE, to: @event.creator.phone, body: "Fellowship Church: Please check in what items you used for your event #{@event.title}." 
	flash[:notice] = "Message Sent"
	redirect_to admin_path
  end

  #Text to tell user their account is activated
  def account_activated
  	@user = User.find(params[:id])
  	client = Twilio::REST::Client.new "ACacbc302876de38b8d7c08fc2ae0536b1", "c0e07871ca06a2ab7c2864aeb0f86c61"
	message = client.messages.create from: Rails.application.config.TWILIO_PHONE, to: @user.phone, body: "Fellowship Church: #{@user.name}, your account has been activated." 
	redirect_to admin_path
  end

  #Text to tell user their account was denied
  def account_denied
  	set_message
  	@user = User.find(params[:id])
  	client = Twilio::REST::Client.new "ACacbc302876de38b8d7c08fc2ae0536b1", "c0e07871ca06a2ab7c2864aeb0f86c61"
	message = client.messages.create from: Rails.application.config.TWILIO_PHONE, to: @user.phone, body: "Fellowship Church: #{@user.name}, your account has been denied. Administrator message: #{@message}" 
	redirect_to admin_path
  end

  #Text to tell user their event was approved
  def event_approved
  	@event = Event.find(params[:id])
  	client = Twilio::REST::Client.new "ACacbc302876de38b8d7c08fc2ae0536b1", "c0e07871ca06a2ab7c2864aeb0f86c61"
	message = client.messages.create from: Rails.application.config.TWILIO_PHONE, to: @event.creator.phone, body: "Fellowship Church: #{@event.creator.name}, your event, #{@event.title}, has been approved." 
	redirect_to admin_path
  end

  #Text to tell user their event was denied
  def event_denied
  	set_message
  	@event = Event.find(params[:id])
  	client = Twilio::REST::Client.new "ACacbc302876de38b8d7c08fc2ae0536b1", "c0e07871ca06a2ab7c2864aeb0f86c61"
	message = client.messages.create from: Rails.application.config.TWILIO_PHONE, to: @event.creator.phone, body: "Fellowship Church: #{@event.creator.name}, your event, #{@event.title}, has been denied. Administrator message: #{@message}" 
	redirect_to admin_path
  end
 

  private

 	def set_message
      @message = params[:message]
    end
end