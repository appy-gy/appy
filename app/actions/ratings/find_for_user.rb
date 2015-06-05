module Ratings
  class FindForUser
    attr_reader :current_user, :user

    def initialize current_user, user
      @current_user = current_user
      @user = user
    end

    def call
      ratings = user.ratings.includes(:tags)
      ratings = ratings.published unless Users::CanSeeDrafts.new(current_user, user).call
      ratings.order 'updated_at DESC'
    end
  end
end
