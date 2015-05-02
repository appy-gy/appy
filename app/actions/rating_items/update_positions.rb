module RatingItems
  class UpdatePositions
    attr_reader :rating, :positions

    def initialize rating, positions
      @rating = rating
      @positions = positions
    end

    def call
      rating.items.each_with_object({}) do |rating_item, new_positions|
        position = positions[rating_item.id]
        rating_item.update position: position
        new_positions[rating_item.id] = rating_item.position
      end
    end
  end
end
