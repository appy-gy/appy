module Ratings
  class CountView
    attr_reader :rating, :ip

    const :expire, 60

    def initialize rating, ip
      @rating = rating
      @ip = ip
    end

    def call
      key = "ratingview:#{rating.id}:#{ip}"
      return unless client.exists key
      client.set key, 1
      client.expire key, expire
      rating.views.increment
    end

    private

    def client
      Redis.current
    end
  end
end
