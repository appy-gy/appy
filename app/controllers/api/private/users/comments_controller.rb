module Api
  module Private
    module Users
      class CommentsController < BaseController
        find :user

        def index
          comments = ::Comments::FindForUser.new(@user).call
          render json: comments
        end
      end
    end
  end
end
