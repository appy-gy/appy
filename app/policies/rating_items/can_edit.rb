module RatingItems
  class CanEdit < BasePolicy
    arguments :rating_item

    def call
      Ratings::CanEdit.new(current_user, rating_item.rating).call
    end
  end
end
