module Api
  module Private
    module Users
      class CommentsController < BaseController
        find :user

        def index
          comments = ::Comments::FindForUser.new(@user, @page).call
          render json: comments, meta: { pages_count: comments.total_pages }
        end
      end
    end
  end
end
