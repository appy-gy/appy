module Ratings
  class FindForUser
    attr_reader :user

    def initialize user
      @user = user
    end

    def call
      user.ratings
    end
  end
end
