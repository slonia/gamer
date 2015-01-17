class WeeklyEmailWorker
  include Sidekiq::Worker

  def perform(id)
    User.find(id).send_weekly_email
  end
end
