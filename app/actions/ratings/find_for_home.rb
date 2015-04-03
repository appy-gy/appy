module Ratings
  class FindForHome
    def call
      Rating.includes(:section, :tags).last(10)
    end
  end
end
