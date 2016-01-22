module Ratings
  class SetLike
    attr_reader :rating, :user

    def initialize rating, user
      @rating = rating
      @user = user
    end

    def call
      @rating.like = rating.likes.of(user).first
    end
  end
end
