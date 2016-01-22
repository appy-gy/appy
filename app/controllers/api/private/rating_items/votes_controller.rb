module Api
  module Private
    module RatingItems
      class VotesController < BaseController
        find :rating_item

        def create
          vote = ::Votes::Create.new(@rating_item, current_user, vote_params).call
          render json: vote, meta: { mark: vote.rating_item.mark }
        end

        private

        def vote_params
          params.require(:vote).permit(:kind)
        end
      end
    end
  end
end
