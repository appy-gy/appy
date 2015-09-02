# Based on Jaccard Index

module Ratings
  class Recommendations
    def initialize rating_data, ratings
      @current_rating = rating_data
      @ratings = ratings
    end

    def recommendations
      @ratings.map! do |rating_data|
        next if @current_rating[0] == rating_data[0]
        current_rating_words = @current_rating[1]
        rating_words = rating_data[1]

        intersection = (current_rating_words & rating_words).size
        union = (current_rating_words | rating_words).size

        rating_data[2] = (intersection.to_f / union.to_f)

        rating_data
      end.compact!.sort_by{ |rating| 1 - rating[2] }
    end

  end
end
