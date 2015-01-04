class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def omniauth_action
    @user = User.find_for_oauth(env["omniauth.auth"], current_user)
    if @user.created_from_identity
      sign_in @user
      redirect_to edit_user_registration_path
    else
      sign_in_and_redirect @user, event: :authentication
    end
  end

  def facebook
    omniauth_action
  end

  def twitter
    omniauth_action
  end

  def vkontakte
    omniauth_action
  end
end
