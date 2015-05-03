module Likes
  class Create
    attr_reader :rating, :user

    def initialize rating, user
      @rating = rating
      @user = user
    end

    def call
      rating.likes.create user: user
      rating.likes.count
    end
  end
end
