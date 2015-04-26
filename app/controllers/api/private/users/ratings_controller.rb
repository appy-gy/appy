module Api
  module Private
    module Users
      class RatingsController < BaseController
        find :user

        def index
          ratings = ::Ratings::FindForUser.new(@user).call
          render json: ratings
        end

        private

        def rating_params
          params.require(:rating).permit(:title, :description, :section_id)
        end
      end
    end
  end
end
