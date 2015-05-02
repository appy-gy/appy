module Api
  module Private
    class RatingItemsController < BaseController
      find :rating, only: [:index, :create, :positions]
      find :rating_item, only: [:update]

      def index
        rating_items = RatingItems::FindForRating.new(@rating).call
        render json: rating_items
      end

      def create
        rating_item = RatingItems::Create.new(@rating, rating_item_params).call
        render json: rating_item
      end

      def update
        rating_item = RatingItems::Update.new(@rating_item, rating_item_params).call
        render json: rating_item
      end

      def positions
        positions = RatingItems::UpdatePositions.new(@rating, params[:positions]).call
        render json: { positions: positions }
      end

      private

      def rating_item_params
        fields = %i{title description position}
        fields << :id if action_name == 'create'
        params.require(:rating_item).permit(*fields)
      end
    end
  end
end
