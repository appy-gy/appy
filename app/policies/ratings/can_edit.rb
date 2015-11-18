module Ratings
  class CanEdit < BasePolicy
    arguments :rating

    def call
      current_user == rating.user or current_user.try(:admin?)
    end
  end
end
