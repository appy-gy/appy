module Search
  class Tags
    attr_reader :query

    def initialize query
      @query = query
    end

    def call
      TagsIndex.query(query).load.to_a
    end

    private

    def query
      { prefix: { name: @query } }
    end
  end
end
