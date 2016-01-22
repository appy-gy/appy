module Api
  module Private
    class TagsController < BaseController
      find :tag, only: [:show]
      
      def index
        tags = ::Search::Tags.new(params[:query]).call
        render json: tags
      end

      def popular
        tags = ::Tags::FindPopular.new.call
        render json: tags
      end

      def show
        render json: @tag
      end
    end
  end
end
