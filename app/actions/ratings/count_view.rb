module Ratings
  class CountView
    attr_reader :rating, :ip

    const :delay, 1.minute

    def initialize rating, ip
      @rating = rating
      @ip = ip
    end

    def call
      return rating.views.value if Redis.current.exists key
      Redis.current.set key, 1, ex: delay
      rating.views.increment
    end

    private

    def key
      @key ||= "ratingview:#{rating.id}:#{ip}"
    end
  end
end
