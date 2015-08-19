module Ratings
  class FindSimilar
    attr_reader :rating

    const :types, %i{with_same_section with_same_tags other}
    const :limit, 3

    def initialize rating
      @rating = rating
    end

    def call
      ids = Set.new
      types.take_while do |type|
        ids.merge send(type).limit(limit).pluck(:id)
        ids.count < limit
      end
      Rating.includes(:section, :tags).where(id: ids.to_a).limit(limit)
    end

    private

    def ratings
      Rating.published.where.not(id: rating)
    end

    alias :other :ratings

    def with_same_section
      ratings.where section: rating.section
    end

    def with_same_tags
      ratings.joins(:tags).where(tags: { id: rating.tags }).uniq
    end
  end
end
