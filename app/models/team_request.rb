class TeamRequest < ActiveRecord::Base
  include TeamRequestStates
  belongs_to :team
  belongs_to :user

  def request_accepted
    user.update_column(:team_id, self.team.id)
    self.update_column(:status, :accepted)
  end
end
