class ApplicationController < ActionController::Base
  include ReactIntegration
  include EasySerialize

  protect_from_forgery with: :exception

  helper_method :react_context, :react_store, :react_storages, :serialize

  before_action :store_current_user

  def store_current_user
    react_store 'CurrentUserStorage', serialize(current_user, root: false)
  end
end
