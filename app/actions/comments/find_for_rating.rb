module Comments
  class FindForRating
    attr_reader :rating

    def initialize rating
      @rating = rating
    end

    def call
      rating.comments
    end
  end
end
