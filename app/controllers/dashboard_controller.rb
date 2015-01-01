class DashboardController < ApplicationController
  def index
    @teams = Team.limit(10)
    @games = Game.active.limit(10)
    @users = User.limit(10)
  end
end
