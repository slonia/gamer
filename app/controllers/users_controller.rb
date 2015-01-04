class UsersController < ApplicationController
  authorize_resource

  def show
    @user = current_user
  end
end
