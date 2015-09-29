module Ratings
  class Unpublish
    attr_reader :rating

    def initialize rating
      @rating = rating
    end

    def call
      rating.update status: :draft, published_at: nil
    end
  end
end
