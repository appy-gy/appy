module Api
  module Private
    class RatingItemsController < BaseController
      def video_info
        info = ::RatingItems::GetVideoInfo.new(params[:url]).call
        render json: info
      end
    end
  end
end
