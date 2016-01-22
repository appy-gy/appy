module Api
  module Private
    class MainPageRatingsController < BaseController
      def show
        ratings = ::MainPageRatings::Find.new.call
        render json: ratings
      end
    end
  end
end
