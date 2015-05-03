module Api
  module Private
    module Ratings
      class LikesController < BaseController
        find :rating

        def create
          likes_count = Likes::Create.new(@rating, current_user).call
          render json: { likes_count: likes_count }
        end
      end
    end
  end
end
