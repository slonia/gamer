class AppMailer < ActionMailer::Base
  default from: "from@example.com"
  # layout 'mailer'

  def user_created(user)
    @user = user
    @team = user.team
    mail(to: @user.email, subject: 'User created')
  end

  def weekly_mail(user)
    @user = user
    @games = Game.for_next_week
    mail(to: @user.email, subject: 'Next week games')
  end
end
