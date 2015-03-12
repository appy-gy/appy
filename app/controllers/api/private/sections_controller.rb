module Api
  module Private
    class SectionsController < BaseController
      def index
        render json: Section.all
      end
    end
  end
end
