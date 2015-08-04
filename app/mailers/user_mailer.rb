class UserMailer < ActionMailer::Base
  def reset_password user
    @user = user
    mail to: @user.email, subject: 'Восстановление пароля'
  end
end
