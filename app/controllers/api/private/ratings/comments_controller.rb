module Api
  module Private
    module Ratings
      class CommentsController < BaseController
        find :rating

        def index
          comments = ::Comments::FindForRating.new(@rating).call
          render json: comments
        end

        def create
          params = comment_params.merge user: current_user
          comment = ::Comments::Create.new(@rating, params).call
          render json: comment
        end

        private

        def comment_params
          params.require(:comment).permit(:body)
        end
      end
    end
  end
end
