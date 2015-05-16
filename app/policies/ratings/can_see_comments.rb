module Ratings
  class CanSeeComments < BasePolicy
    arguments :rating

    def call
      rating.published?
    end
  end
end
