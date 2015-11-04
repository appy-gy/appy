module Ratings
  class Create
    attr_reader :user

    def initialize user
      @user = user
    end

    def call
      user.ratings.create.tap do |rating|
        2.times { |n| rating.items.create position: n }
      end
    end
  end
end
