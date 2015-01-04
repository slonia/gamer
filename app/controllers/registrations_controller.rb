class RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters

  def update
    if @user.update_attributes(account_update_params)
      redirect_to root_path
    else
      render 'edit'
    end
  end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) do |u|
        u.permit(:name, :request_for_team_id, :new_team, :email, :password, :password_confirmation)
      end
      devise_parameter_sanitizer.for(:account_update) do |u|
        params_array = [:name, :request_for_team_id, :new_team, :email]
        u.permit(params_array)
      end
   end
end
