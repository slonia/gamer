class GameVisitsController < ApplicationController

  def set
    if params[:game_id] && params[:user_id]
      @game_visit = GameVisit.find_or_initialize_by(game_id: params[:game_id], user_id: params[:user_id])
      @game_visit.update_attributes(game_visit_params)

      render json: @game_visit
    end
  end

  private

    def game_visit_params
      params.permit(:status)
    end
end
