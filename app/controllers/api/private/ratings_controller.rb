module Api
  module Private
    class RatingsController < BaseController
      find :rating, only: [:show, :update, :destroy, :similar, :view]
      check 'Ratings::CanEdit', :@rating, only: [:update, :destroy]

      def index
        ratings = ::Ratings::FindForHome.new(@page).call
        render json: ratings, meta: { pages_count: ratings.total_pages }
      end

      def show
        ::Ratings::SetLike.new(@rating, current_user).call
        render json: @rating
      end

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

      def similar
        ratings = ::Ratings::FindSimilar.new(@rating).call
        render json: ratings
      end

      def main_page
        ratings = ::Rating::FindForMainPage.new.call
        render json: ratings
      end

      def view
        views_count = ::Ratings::CountView.new(@rating).call
        render json: { views_count: views_count }
      end

      private

      def rating_params
        params.require(:rating).permit(:title, :description, :source,
          :section_id, :image, :status)
      end
    end
  end
end
