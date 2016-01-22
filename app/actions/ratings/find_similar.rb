module Ratings
  class FindSimilar
    attr_reader :rating

    const :types, %i{recommended with_same_section other}
    const :limit, 3

    def initialize rating
      @rating = rating
    end

    def call
      ids = Set.new
      types.take_while do |type|
        ids.merge send(type).pluck(:id)
        ids.count < limit
      end
      Rating.includes(:section, :tags).where(id: ids.to_a).limit(limit)
    end

    private

    def recommended
      Rating.where id: rating.recommendations
    end

    def ratings
      Rating.published.where.not(id: rating.id).order(likes_count: :desc).limit(limit)
    end

    alias :other :ratings

    def with_same_section
      ratings.where section: rating.section
    end
  end
end
