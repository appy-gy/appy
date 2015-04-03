module Api
  module Private
    class RatingsController < BaseController
      find :rating, only: [:show, :update]

      def index
        render json: Ratings::FindForHome.new.call
      end

      def show
        render json: @rating
      end

      def update
        render json: @rating.update(rating_params)
      end

      private

      def rating_params
        params.require(:rating).permit(:title, :section_id)
      end
    end
  end
end
