class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.find_for_oauth(env["omniauth.auth"], current_user)
    sign_in_and_redirect @user, event: :authentication
  end
end
