module Ratings
  class CanComment < BasePolicy
    arguments :rating

    def call
      current_user.present? and rating.published?
    end
  end
end
