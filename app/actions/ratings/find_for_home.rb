module Ratings
  class FindForHome
    def call
      Rating.includes(:section, :tags, :items).published.last(10)
    end
  end
end
