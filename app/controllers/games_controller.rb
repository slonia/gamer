class GamesController < ApplicationController
  load_and_authorize_resource

  def new
  end

  def create
    if (@game = Game.create(game_params)) && @game.update_column(:added_by_id, current_user.id)
      redirect_to root_path
    else
      render 'new'
    end
  end

  def game_params
    params.require(:game).permit(:name, :date)
  end
end
