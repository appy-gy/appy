module Ratings
  class RemoveTag
    attr_reader :rating, :name

    def initialize rating, name
      @rating = rating
      @name = name
    end

    def call
      rating.tags.delete tag
    end

    private

    def tag
      @tag ||= Tag.find_by name: name
    end
  end
end
