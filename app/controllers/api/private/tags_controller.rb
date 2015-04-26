module Api
  module Private
    class TagsController < BaseController
      def index
        tags = ::Tags::Autocomplete.new(params[:query]).call
        render json: tags, root: :tags
      end
    end
  end
end
