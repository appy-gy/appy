module Ratings
  class Destroy
    attr_reader :rating

    def initialize rating
      @rating = rating
    end

    def call
      rating.tap &:destroy
    end
  end
end
