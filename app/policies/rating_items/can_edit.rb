module RatingItems
  class CanEdit < BasePolicy
    arguments :rating_item

    def call
      current_user == rating_item.rating.user
    end
  end
end
