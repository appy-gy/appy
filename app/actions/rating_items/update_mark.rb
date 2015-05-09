module RatingItems
  class UpdateMark
    attr_reader :rating_item

    def initialize rating_item
      @rating_item = rating_item
    end

    def call
      rating_item.mark = votes.up.count - votes.down.count
      rating_item.tap &:save
    end

    delegate :votes, to: :rating_item
  end
end
