module Ratings
  class FindSimilar
    attr_reader :rating

    def initialize rating
      @rating = rating
    end

    def call
      return @rating.recommendations if @rating.recommendations.present?
      @rating.recommendations = Ratings::Recommendations.new(@rating, ratings).recommendations.first(Rating::recommendations_limit)
    end

    private

    def ratings
      Rating.published.where.not(id: rating)
    end

  end
end
