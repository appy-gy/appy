class ApplicationController < ActionController::Base
  include ReactIntegration
  include EasySerialize

  protect_from_forgery with: :exception

  helper_method :react_context, :react_store, :react_stores, :serialize

  before_action :store_current_user

  def store_current_user
    react_store 'CurrentUserStore', serialize(current_user, root: false)
  end
end
