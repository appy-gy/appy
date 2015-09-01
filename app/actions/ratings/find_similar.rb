module Ratings
  class FindSimilar
    attr_reader :rating

    def initialize rating
      @rating = rating
    end

    def call
      Rating.find @rating.recommendations
    end

    private

    def ratings
      Rating.published.where.not(id: rating)
    end

  end
end
