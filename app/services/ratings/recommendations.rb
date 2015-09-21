# Based on Jaccard Index

module Ratings
  class Recommendations
    const :limit, 3

    class Data
      attr_reader :id, :words

      def initialize id, words
        @id = id
        @words = words.to_set
      end
    end

    def for current_rating
      current_rating = Data.new *current_rating.slice(:id, :words).values
      indexes_for(current_rating).sort_by{ |_, index| 1 - index }.first(limit).map(&:first)
    end

    private

    def indexes_for current_rating
      ratings.each_with_object({}) do |rating, indexes|
        next if rating.id == current_rating.id
        intersection = (current_rating.words & rating.words).size
        union = (current_rating.words | rating.words).size
        indexes[rating.id] = intersection.to_f / union.to_f
      end
    end

    def ratings
      @ratings ||= Rating.published.pluck(:id, :words).map { |data| Data.new *data }
    end
  end
end
