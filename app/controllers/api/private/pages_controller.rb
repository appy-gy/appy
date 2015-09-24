module Api
  module Private
    class PagesController < BaseController
      find :page, only: [:show]

      def show
        render json: @page
      end

      def footer
        pages = ::Pages::FindForFooter.new.call
        render json: pages
      end
    end
  end
end
