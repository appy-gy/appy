module Tags
  class Autocomplete
    attr_reader :query

    def initialize query
      @query = query
    end

    def call
      # TODO
      Tag.all
    end
  end
end
