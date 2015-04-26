module Api
  module Private
    class RatingsController < BaseController
      find :rating, only: [:show, :update]

      def index
        render json: ::Ratings::FindForHome.new.call
      end

      def show
        render json: @rating
      end

      def update
        rating = ::Ratings::Update.new(@rating, rating_params).call
        render json: rating
      end

      def create
        render json: current_user.ratings.create
      end

      private

      def rating_params
        params.require(:rating).permit(:title, :description, :section_id)
      end
    end
  end
end
