module Votes
  class Create
    attr_reader :user, :rating_item, :params

    def initialize rating_item, user, params
      @user = user
      @rating_item = rating_item
      @params = params
    end

    def call
      vote.attributes = params
      vote.tap &:save
    end

    private

    def vote
      @vote ||= Vote.of(user).for(rating_item).first_or_initialize
    end
  end
end
