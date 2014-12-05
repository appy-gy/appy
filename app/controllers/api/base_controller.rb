module Api
  class BaseController < ActionController::Metal
    include AbstractController::Rendering
    include ActionController::Rendering
    include ActionController::Renderers::All
    include AbstractController::Callbacks
    include ActionController::Helpers
    include ActionController::Cookies
    include ActionController::Serialization
    include ActionController::Rescue
    include ActionController::StrongParameters
    include ActionController::DataStreaming
    include ActionController::RequestForgeryProtection
    include Rails.application.routes.url_helpers

    include Sorcery::Controller

    include EasySerialize

    before_action :override_request_formats

    private

    def override_request_formats
      request.formats = [:json]
    end
  end
end
