module Api
  module Private
    class RatingItemsController < BaseController
      find :rating, only: [:index, :create, :positions]
      find :rating_item, only: [:update]
      check 'RatingItems::CanEdit', :@rating_item, only: [:update]

      def index
        rating_items = ::RatingItems::FindForRating.new(@rating, current_user).call
        render json: rating_items
      end

      def create
        rating_item = ::RatingItems::Create.new(@rating, rating_item_params).call
        render json: rating_item
      end

      def update
        rating_item = ::RatingItems::Update.new(@rating_item, rating_item_params).call
        render json: rating_item
      end

      def positions
        positions = ::RatingItems::UpdatePositions.new(@rating, params[:positions]).call
        render json: { positions: positions }
      end

      private

      def rating_item_params
        params.require(:rating_item).permit(:title, :description, :position, :image)
      end
    end
  end
end
