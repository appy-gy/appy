module Tags
  class Autocomplete
    attr_reader :query

    def initialize query
      @query = query
    end

    def call
      Tag.search query
    end
  end
end
