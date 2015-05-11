module RatingItems
  class Update
    attr_reader :rating_item, :params

    def initialize rating_item, params
      @rating_item = rating_item
      @params = params
    end

    def call
      rating_item.update params
    end
  end
end
