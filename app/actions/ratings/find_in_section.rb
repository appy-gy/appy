module Ratings
  class FindInSection
    attr_reader :section

    def initialize section
      @section = section
    end

    def call
      section.ratings
    end
  end
end
