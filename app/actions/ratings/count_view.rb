module Ratings
  class CountView
    attr_reader :rating

    def initialize rating
      @rating = rating
    end

    def call
      rating.views.increment
    end
  end
end
