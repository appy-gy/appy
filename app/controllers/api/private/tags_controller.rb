module Api
  module Private
    class TagsController < BaseController
      def index
        tags = ::Tags::Autocomplete.new(params[:query]).call
        ::Tags::SetNumberOfUses.new(tags).call
        render json: tags, each_serializer: TagForAutocompleteSerializer
      end
    end
  end
end
