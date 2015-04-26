module Ratings
  class AddTag
    attr_reader :rating, :name

    def initialize rating, name
      @rating = rating
      @name = name
    end

    def call
      rating.tags.push tag
    end

    private

    def tag
      @tag ||= Tags::Create.new(name).call
    end
  end
end
