module Ratings
  class Update
    attr_reader :rating, :params

    def initialize rating, params
      @rating = rating
      @params = params
    end

    def call
      rating.update params
      rating
    end
  end
end
