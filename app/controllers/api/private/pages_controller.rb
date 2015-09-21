module Api
  module Private
    class PagesController < BaseController
      find :page

      def show
        render json: @page
      end
    end
  end
end
