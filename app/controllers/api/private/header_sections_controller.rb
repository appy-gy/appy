module Api
  module Private
    class HeaderSectionsController < BaseController
      def index
        render json: Sections::FindForHeader.new.call, root: :sections
      end
    end
  end
end
