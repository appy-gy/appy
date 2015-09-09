module Comments
  class FindForRating
    attr_reader :rating

    def initialize rating
      @rating = rating
    end

    def call
      rating.comments.includes(:user, rating: :section)
    end
  end
end
