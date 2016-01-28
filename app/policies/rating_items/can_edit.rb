module RatingItems
  class CanEdit < BasePolicy
    arguments :rating_item

    def call
      current_user.present? and (current_user == rating_item.rating.user or current_user.admin?)
    end
  end
end
