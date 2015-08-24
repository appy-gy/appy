module Ratings
  class FindSimilar
    attr_reader :rating

    const :limit, 3

    def initialize rating
      @rating = rating
    end

    def call
      Ratings::Recommendations.new(@rating, ratings).recommendations.first(limit)
    end

    private

    def ratings
      Rating.published.where.not(id: rating)
    end
    
  end
end
