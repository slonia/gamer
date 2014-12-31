class AppMailer < ActionMailer::Base
  default from: "from@example.com"
  # layout 'mailer'

  def user_created(user)
    @user = user
    @team = user.team
    mail(to: @user.email, subject: 'User created')
  end
end
