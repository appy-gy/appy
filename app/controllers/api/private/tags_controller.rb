module Api
  module Private
    class TagsController < BaseController
      def index
        tags = ::Tags::Autocomplete.new(params[:query]).call
        render json: tags
      end

      def popular
        tags = ::Tags::FindPopular.new.call
        render json: tags
      end
    end
  end
end
