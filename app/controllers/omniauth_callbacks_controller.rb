class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def omniauth_action
    @user = User.find_for_oauth(env["omniauth.auth"], current_user)
    if @user
      sign_in_and_redirect @user, event: :authentication
    else
      flash[:alert] = 'Error'
      redirect_to root_path
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
