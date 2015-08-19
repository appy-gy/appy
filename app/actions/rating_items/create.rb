module RatingItems
  class Create
    attr_reader :rating, :params

    def initialize rating, params
      @rating = rating
      @params = params
    end

    def call
      shift_items!
      rating.items.create params
    end

    private

    def shift_items!
      position = params[:position].to_i
      positions = rating.items
        .select { |item| item.position >= position }
        .each_with_object({}) { |item, result| result[item.id] = item.position + 1 }
      UpdatePositions.new(rating, positions).call
    end
  end
end
