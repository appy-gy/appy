class ApplicationController < ActionController::Base
  include ReactIntegration
  include EasySerialize

  protect_from_forgery with: :exception

  # TODO: replace with real code
  def current_user
  end
  helper_method :current_user
end
