class TeamsController < ApplicationController
  load_and_authorize_resource find_by: :slug

  def index
  end

  def show
    @users = @team.users
  end
end
