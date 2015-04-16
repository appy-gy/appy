module Ratings
  class FindForHome
    def call
      Rating.includes(:section, :tags, :items).last(10)
    end
  end
end
