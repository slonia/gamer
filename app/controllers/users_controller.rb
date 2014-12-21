class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @games = Game.all
  end
end
