module Api
  module Private
    class HeaderSectionsController < BaseController
      def index
        render json: Section::FindForHeader.new.call, root: :sections
      end
    end
  end
end
