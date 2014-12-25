class Admin::AdminController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!
  before_action :check_admin!

  private

    def check_admin!
      redirect_to new_admin_user_session_path unless current_user && current_user.admin?
    end
end
