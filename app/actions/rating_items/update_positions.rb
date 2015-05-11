module RatingItems
  class UpdatePositions
    attr_reader :rating, :positions

    def initialize rating, positions
      @rating = rating
      @positions = positions
    end

    def call
      Queries::BulkUpdate.new(RatingItem, changes).call
      RatingItem.where(id: ids).pluck(:id, :position).to_h
    end

    private

    def changes
      positions.transform_values { |position| { position: position } }
    end

    def ids
      positions.keys
    end
  end
end
