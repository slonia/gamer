class TeamsController < ApplicationController
  load_and_authorize_resource find_by: :slug

  def index
    if request.xhr?
      render json: @teams.to_json
    else
      render text: '', layout: true
    end
  end

  def show
    @team = Team.find_by_slug!(params[:slug])
    if params[:page].nil? || (params[:page].to_s == '1')
      @users = @team.users.pluck(:name)
      @games = @team.team_hash
    else
      render json: { games: @team.team_json(params[:page]) }
    end
  end
end
