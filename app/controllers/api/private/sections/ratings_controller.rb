module Api
  module Private
    module Sections
      class RatingsController < BaseController
        find :section

        def index
          ratings = ::Ratings::FindInSection.new(@section).call
          render json: ratings
        end
      end
    end
  end
end
