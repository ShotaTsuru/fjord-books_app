# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'

  def welcome_email
    @user = params[:user]
    @url  = new_user_password_path
    mail(to: @user.email, subject: 'パスワードの再設定')
  end
end
