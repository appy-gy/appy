module Api
  module Private
    class RatingItemsController < BaseController
      find :rating_item, only: [:update]
      find :rating, only: [:index]

      def index
        render json: @rating.items
      end

      def update
        render json: @rating_item.update(rating_item_params)
      end

      private

      def rating_item_params
        params.require(:rating_item).permit(:title, :description)
      end
    end
  end
end
