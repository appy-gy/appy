module Ratings
  class FindPrevNext
    attr_reader :rating

    def initialize rating
      @rating = rating
    end

    def call
      Rating.all.sample(2)
    end
  end
end
