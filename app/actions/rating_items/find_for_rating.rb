module RatingItems
  class FindForRating
    attr_reader :rating

    def initialize rating
      @rating = rating
    end

    def call
      rating.items
    end
  end
end
