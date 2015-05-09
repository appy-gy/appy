module Api
  module Private
    module Ratings
      class LikesController < BaseController
        find :rating

        def create
          like = Likes::Create.new(@rating, current_user).call
          render json: like, meta: { likes_count: like.rating.likes_count }
        end
      end
    end
  end
end
