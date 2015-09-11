class OauthsController < ApplicationController
  include Sorcery::Controller

  def oauth
    login_at auth_params[:provider]
  end

  def callback
    provider = auth_params[:provider]
    redirect_to '/'
    return if login_from provider
    user = create_from provider
    reset_session
    auto_login user
  end

  private

  def auth_params
    params.permit :code, :provider
  end
end
