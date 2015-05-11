module RatingItems
  class Create
    attr_reader :rating, :params

    def initialize rating, params
      @rating = rating
      @params = params
    end

    def call
      rating.items.create params
    end
  end
end
