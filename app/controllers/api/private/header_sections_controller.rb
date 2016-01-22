module Api
  module Private
    class HeaderSectionsController < BaseController
      def index
        sections = ::Sections::FindForHeader.new.call
        render json: sections, root: :sections
      end
    end
  end
end
