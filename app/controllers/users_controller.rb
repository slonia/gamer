class UsersController < ApplicationController
  authorize_resource

  def show
    @user = current_user
    if request.xhr?
      render json: @user.to_json
    else
      render text: '', layout: true
    end
  end
end
