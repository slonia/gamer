class TeamRequestsController < ApplicationController
  before_action :authorize_team_request

  def accept
    @team_request.accept
    redirect_to team_path(@team.slug)
  end

  def reject
    @team_request.reject
    redirect_to team_path(@team.slug)
  end

  private

    def authorize_team_request
      @team = Team.find_by_slug(params[:slug])
      @user = User.find(params[:id])
      @team_request = TeamRequest.pending.find_by(team_id: @team.id, user_id: @user.id)
    end
end
