class UsersController < ApplicationController
  authorize_resource

  def show
    @user = current_user
  end

  def weekly_toggle
    result = current_user.weekly_toggle(params[:provider])
    render json: {status: result}
  end
end
