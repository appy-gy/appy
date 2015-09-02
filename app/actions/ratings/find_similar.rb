module Ratings
  class FindSimilar
    attr_reader :rating

    def initialize rating
      @rating = rating
    end

    def call
      Rating.find @rating.recommendations
    end
  end
end
