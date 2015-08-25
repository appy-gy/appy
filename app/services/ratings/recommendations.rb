# Based on Jaccard Index

module Ratings
  class Recommendations
    attr_reader :rating, :ratings

    def initialize rating, ratings
      @current_rating, @ratings = rating, ratings
    end

    def recommendations
      @ratings.map do |rating|
        rating.define_singleton_method(:jaccard_index) do
          @jaccard_index
        end

        rating.define_singleton_method(:jaccard_index=) do |index|
          @jaccard_index = index || 0.0
        end

        intersection = (@current_rating.words & rating.words).size

        union = (@current_rating.words | rating.words).size

        rating.jaccard_index = (intersection.to_f / union.to_f) rescue 0.0

        rating
      end.sort_by{ |rating| 1 - rating.jaccard_index }
    end

  end
end
