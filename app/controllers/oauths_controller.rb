class OauthsController < ApplicationController
  include Sorcery::Controller

  def oauth
    session[:return_to_url] = request.referer
    login_at auth_params[:provider]
  end

  def callback
    return_to_url = session[:return_to_url]
    provider = auth_params[:provider]
    return if login_from provider
    user = create_from provider do |user|
      user.send :set_fake_slug
      user.generate_email
      user.generate_password
    end
    reset_session
    auto_login user, true
  ensure
    session[:return_to_url] = return_to_url
    redirect_back_or_to '/'
  end

  private

  def auth_params
    params.permit :code, :provider
  end
end
