class OauthsController < ApplicationController
  include Sorcery::Controller

  def oauth
    login_at auth_params[:provider]
  end

  def callback
    provider = auth_params[:provider]
    if login_from provider
      redirect_to '/'
    else
      user = create_and_validate_from provider
      user.generate_password
      user.generate_email
      user = User.find_by(email: user.email) unless user.save

      reset_session
      auto_login user
      redirect_to '/'
    end
  rescue
    redirect_to '/'
  end

  private

  def auth_params
    params.permit :code, :provider
  end
end
