module Api
  module Private
    class RatingsController < BaseController
      before_action :find_rating, only: [:show, :update]

      def index
        render json: Rating::FindForHome.new.call
      end

      def show
        render json: @rating
      end

      def update
        render json: @rating.update(rating_params)
      end

      private

      def find_rating
        @rating = Rating.find params[:id]
      end

      def rating_params
        params.require(:rating).permit(:title, :section_id)
      end
    end
  end
end
