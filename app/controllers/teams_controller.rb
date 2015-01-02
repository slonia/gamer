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
    if request.xhr?
      render(partial: 'teams/games', locals: { games: @team.team_hash(params[:page])})
    else
      @users = @team.users.pluck(:name)
      @games = @team.team_hash(params[:page])
      @total_pages = Game.active.page(1).total_pages
    end
  end
end
