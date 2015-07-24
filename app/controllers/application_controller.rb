class ApplicationController < ActionController::Base
  include Sorcery::Controller

  def access_denied
    redirect_to '/'
  end
end
