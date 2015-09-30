module Api
  module Private
    class SearchesController < BaseController
      def global
        results = Search::Global.new(params[:query], @page).call
        render json: results, serializer: SearchResultsSerializer
      end
    end
  end
end
