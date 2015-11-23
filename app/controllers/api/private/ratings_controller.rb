module Api
  module Private
    class RatingsController < BaseController
      find :rating, only: [:show, :update, :destroy, :similar, :view]
      check 'Ratings::CanEdit', :@rating, only: [:update, :destroy]

      def create
        rating = ::Ratings::Create.new(current_user).call
        render json: rating
      end

      def update
        rating = ::Ratings::Update.new(@rating, rating_params).call
        render json: rating
      end

      def destroy
        rating = ::Ratings::Destroy.new(@rating).call
        render json: { success: rating.deleted? }
      end

      private

      def rating_params
        params.require(:rating).permit(:title, :description, :source,
          :section_id, :image, :status)
      end
    end
  end
end
