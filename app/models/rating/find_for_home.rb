class Rating
  class FindForHome
    def call
      Rating.last 10
    end
  end
end
