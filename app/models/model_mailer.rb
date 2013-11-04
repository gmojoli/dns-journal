class ModelMailer < ActionMailer::Base
  default from: "me@dns-journal.mailgun.org"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.model_mailer.new_user_notification.subject
  #
  def new_user_notification(user)
    @user = user
    mail to: user.email, subject: "Welcome to Dns Journal"
  end
end
