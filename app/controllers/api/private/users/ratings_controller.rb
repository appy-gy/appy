module Api
  module Private
    module Users
      class RatingsController < BaseController
        find :user

        def index
          ratings = ::Ratings::FindForUser.new(current_user, @user, @page).call
          render json: ratings, meta: { pages_count: ratings.total_pages }
        end
      end
    end
  end
end
