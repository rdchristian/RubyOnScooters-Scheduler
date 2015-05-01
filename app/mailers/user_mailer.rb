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

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Password reset"
  end


  def event_approved(user, event)
    @user = user
    @event = event
    mail to: user.email, subject: "Event Approved"
  end

  def check_in_reminder(event)
    @event = event
    @user = event.creator
    mail to: @user.email, subject: "Check-in Reminder"
  end
end
