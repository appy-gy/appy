class ApplicationController < ActionController::Base
  include ReactIntegration
  include EasySerialize

  protect_from_forgery with: :exception
end
