class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject
  #
  def account_activation(user)
    @user = user

    mail to: user.email, subject: "Account Activation"
  end

  def account_denied(user, message)
    @user = user
    @message = message
    mail to: user.email, subject: "Facilities Scheduler: Account Denied"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Facilities Scheduler: Password reset"
  end


  def event_approved(user, event)
    @user = user
    @event = event
    mail to: user.email, subject: "Facilities Scheduler: Event Approved"
  end

  def event_denied(user, event, message)
    @user = user
    @event = event
    @message = message
    mail to: user.email, subject: "Facilities Scheduler: Event Denied"
  end

  def check_in_reminder(event)
    @event = event
    @user = event.creator
    mail to: @user.email, subject: "Facilities Scheduler: Check-in Reminder"
  end

  def admin_email
    @events = Event.all
    @inactive_users = 0
    @unapproved_events = 0
    @unchecked_in_events = 0
    @events.each do |user|
      if !@event.is_approved?
        @unapproved_events += 1
      end
      if !event.resources_checked_in? && event.ending < Time.zone.now
        @unchecked_in_events += 1
      end
    end
    @users = User.all
    @users.each do |user|
      if !@user.is_activated?
        @inactive_users += 1
      end
    end
    @users.each do |user|
      if user.is_admin?
        mail to: @user.email, subject: "Facility Scheduler Admin Summary"
      end
    end
  end
end
