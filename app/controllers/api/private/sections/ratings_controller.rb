module Api
  module Private
    module Sections
      class RatingsController < BaseController
        find :section

        def index
          ratings = ::Ratings::FindInSection.new(@section, @page).call
          render json: ratings, meta: { pages_count: ratings.total_pages }
        end
      end
    end
  end
end
