class OauthsController < ApplicationController
  include Sorcery::Controller

  def oauth
    session[:return_to_url] = request.referer
    login_at auth_params[:provider]
  end

  def callback
    provider = auth_params[:provider]
    user = login_from(provider) || recognize_user(provider) || create_user(provider)
    return unless user
    reset_session
    auto_login user, true
  rescue => e
    Rails.logger.error("Oauth fail. #{e.inspect}. #{e.backtrace.join("\n")}")
  ensure
    redirect_back_or_to '/'
  end

  private

  def recognize_user provider
    recognize_user_by_uid(provider) or recognize_user_by_email(provider)
  end

  def recognize_user_by_uid provider
    user_hash = sorcery_fetch_user_hash(provider)
    uid = user_hash[:uid]
    return unless uid
    authentication = Authentication.find_by_uid(uid)
    authentication.try :user
  end

  def recognize_user_by_email provider
    user_hash = sorcery_fetch_user_hash(provider)
    email = user_hash[:user_info]['email']
    return unless email
    user = User.find_by_email(email)
    user
  end

  def create_user provider
    user = create_and_validate_from provider
    user.generate_password
    user.generate_email
    user.save
    user
  end

  def auth_params
    params.permit :code, :provider
  end
end
