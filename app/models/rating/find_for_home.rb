class Rating
  class FindForHome
    def call
      Rating.last 5
    end
  end
end
