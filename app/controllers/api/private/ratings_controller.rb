module Api
  module Private
    class RatingsController < BaseController
      find :rating, only: [:show, :update]
      check 'Ratings::CanEdit', :@rating, only: [:update]

      def index
        render json: ::Ratings::FindForHome.new.call
      end

      def show
        ::Ratings::SetLike.new(@rating, current_user).call
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
        params.require(:rating).permit(:title, :description, :section_id, :image, :status)
      end
    end
  end
end
