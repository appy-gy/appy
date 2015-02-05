module Api
  module Private
    class RatingsController < BaseController
      def index
        render json: Rating::FindForHome.new.call
      end

      def show
        render json: Rating.find(params[:id])
      end
    end
  end
end
