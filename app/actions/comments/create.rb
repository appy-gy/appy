module Comments
  class Create
    attr_reader :rating, :params

    def initialize rating, params
      @rating = rating
      @params = params
    end

    def call
      rating.comments.create params
    end
  end
end
