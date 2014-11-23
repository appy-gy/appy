class ApplicationController < ActionController::Base
  include ReactIntegration
  include EasySerialize

  protect_from_forgery with: :exception

  before_action :store_current_user

  def store_current_user
    react_store 'CurrentUserStorage', serialize(current_user, root: false)
  end
end
