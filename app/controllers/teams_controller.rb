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
      render json: @team.to_json
    else
      render text: '', layout: true
    end
  end
end
