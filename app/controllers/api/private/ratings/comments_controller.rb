module Api
  module Private
    module Ratings
      class CommentsController < BaseController
        find :rating

        def index
          comments = Comments::FindForRating.new(@rating).call
          render json: comments
        end
      end
    end
  end
end
