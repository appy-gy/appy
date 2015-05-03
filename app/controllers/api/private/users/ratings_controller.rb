module Api
  module Private
    module Users
      class RatingsController < BaseController
        find :user

        def index
          ratings = ::Ratings::FindForUser.new(@user).call
          render json: ratings
        end
      end
    end
  end
end
