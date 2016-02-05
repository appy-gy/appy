module Ratings
  class FindPrevNext
    attr_reader :rating

    const :subquery_select, 'id, lag(id) over (order by published_at asc) as prev_id, lead(id) over (order by published_at asc) as succ_id'

    def initialize rating
      @rating = rating
    end

    def call
      subquery = ratings.select(subquery_select)
      query = Rating.unscoped.from(subquery, :rs).where(rs: { id: rating.id }).select('*')
      prev_id, succ_id = query.to_a.first.slice(:prev_id, :succ_id).values
      prev = prev_id ? Rating.find(prev_id) : other_ratings.last
      succ = succ_id ? Rating.find(succ_id) : other_ratings.first
      [prev, succ]
    end

    private

    def ratings
      rating.section.ratings.published
    end

    def other_ratings
      ratings.where.not(id: rating.id).order(:published_at)
    end
  end
end
