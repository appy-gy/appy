module Api
  module Private
    class RatingsController < BaseController
      def index
        render json: Rating::FindForHome.new.call
      end
    end
  end
end
