module Ratings
  class CanEdit < BasePolicy
    arguments :rating

    def call
      current_user == rating.user
    end
  end
end
