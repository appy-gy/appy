module Likes
  class Destroy
    attr_reader :rating, :user

    def initialize rating, user
      @rating = rating
      @user = user
    end

    def call
      like = rating.likes.of(user).first
      return unless like.present?
      like.destroy
    end
  end
end
