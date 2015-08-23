module Tags
  class FindPopular
    const :limit, 10

    def call
      Tag.order(ratings_count: :desc).limit(limit)
    end
  end
end
