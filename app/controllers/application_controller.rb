class ApplicationController < ActionController::Base
  include ReactStorages

  protect_from_forgery with: :exception
end
