module Api
  module Private
    class RatingItemsController < BaseController
      find :rating_item, only: [:update]
      find :rating, only: [:index, :create]

      def index
        render json: @rating.items
      end

      def create
        render json: @rating.items.create(rating_item_params)
      end

      def update
        render json: @rating_item.update(rating_item_params)
      end

      private

      def rating_item_params
        params.require(:rating_item).permit(:title, :description, :position)
      end
    end
  end
end
