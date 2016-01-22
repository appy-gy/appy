module Api
  module Private
    module Tags
      class RatingsController < BaseController
        find :tag

        def index
          ratings = ::Ratings::FindInTag.new(@tag, @page).call
          render json: ratings, meta: { pages_count: ratings.total_pages }
        end
      end
    end
  end
end
