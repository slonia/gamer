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
    if request.xhr?
      if params[:page].nil? || (params[:page].to_s == '1')
        render json: {
          users: @team.users.pluck(:name),
          games: @team.team_json,
          max_pages: Game.active.page(1).total_pages
        }
      else
        render json: { games: @team.team_json(params[:page]) }
      end
    else
      render text: '', layout: true
    end
  end
end
