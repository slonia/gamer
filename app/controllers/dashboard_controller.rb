class DashboardController < ApplicationController
  def index
    if request.xhr?
      @teams = Team.limit(10)
      @games = Game.active.limit(10)
      @users = User.limit(10)
      render json: {
        teams: @teams,
        games: @games,
        users: @users
      }.to_json
    else
      render text: '', layout: true
    end
  end
end
