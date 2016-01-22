module RatingItems
  class Destroy
    attr_reader :rating_item

    def initialize rating_item
      @rating_item = rating_item
    end

    def call
      rating_item.tap &:destroy
    end
  end
end
