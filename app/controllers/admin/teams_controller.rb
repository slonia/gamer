class Admin::TeamsController < Admin::AdminController
  load_and_authorize_resource

  def index
  end

  def new
  end

  def create
    # binding.pry
    if @team = Team.create(team_params)
      redirect_to admin_teams_path
    else
      render 'new'
    end
  end

  private

    def team_params
      params.require(:team).permit(:name, :mak_id, users_attributes: [:id, :name, :email])
    end
end
