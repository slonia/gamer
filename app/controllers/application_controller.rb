class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  private

    def after_sign_in_path_for(resource)
      if resource.admin?
        root_path
      else
        if resource.team
          team_path(resource.team.slug)
        else
          root_path
        end
      end
    end
end
