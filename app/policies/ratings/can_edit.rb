module Ratings
  class CanEdit < BasePolicy
    arguments :rating

    def call
      current_user.present? and (current_user == rating.user or current_user.admin?)
    end
  end
end
