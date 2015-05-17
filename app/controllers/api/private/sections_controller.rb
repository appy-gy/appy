module Api
  module Private
    class SectionsController < BaseController
      find :section, only: [:show]

      def index
        render json: Section.all
      end

      def show
        render json: @section
      end
    end
  end
end
