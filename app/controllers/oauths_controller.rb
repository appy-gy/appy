class OauthsController < ApplicationController
  include Sorcery::Controller

  def oauth
    session[:return_to_url] = request.referer
    login_at auth_params[:provider]
  end

  def callback
    provider = auth_params[:provider]
    callback_log "Login with #{provider}"
    user = login_from(provider) || recognize_user(provider) || create_user(provider)
    callback_log "Finished user search #{user.inspect}"
    return unless user
    reset_session
    auto_login user, true
    callback_log "Finish auto login #{current_user.inspect}"
  rescue => e
    callback_log "Failed #{e.inspect} #{e.backtrace.join("\n")}"
  ensure
    redirect_back_or_to '/'
  end

  private

  def recognize_user provider
    callback_log 'Start recognition'
    recognize_user_by_uid(provider) or recognize_user_by_email(provider)
  end

  def recognize_user_by_uid provider
    user_hash = sorcery_fetch_user_hash(provider)
    uid = user_hash[:uid]
    callback_log "Recognize by uid #{user_hash.inspect}"
    return unless uid
    authentication = Authentication.find_by_uid(uid)
    callback_log "Auth by uid #{authentication.inspect}"
    authentication.try :user
  end

  def recognize_user_by_email provider
    user_hash = sorcery_fetch_user_hash(provider)
    email = user_hash[:user_info]['email']
    callback_log "Recognize by email #{user_hash.inspect}"
    return unless email
    user = User.find_by_email(email)
    callback_log "Find by email #{user.inspect}"
    user
  end

  def create_user provider
    callback_log 'Creating user'
    user = create_and_validate_from provider
    user.generate_password
    user.generate_email
    user.save
    callback_log "Save user #{user.inspect}"
    user
  end

  def auth_params
    params.permit :code, :provider
  end

  def callback_log msg
    Rails.logger.info "[Oauth callback log] Message: #{msg}"
  end
end
