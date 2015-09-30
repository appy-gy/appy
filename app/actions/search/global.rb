module Search
  class Global
    attr_reader :page

    const :slop, 20
    const :max_expansions, 10
    const :analyzer, 'russian'
    const :per_page, 10

    def initialize query, page
      @query = query
      @page = page
    end

    def call
      GlobalIndex.query(query).page(page).per(per_page).load.to_a
    end

    private

    def query
      { match_phrase_prefix: { _all: { query: @query, slop: slop, max_expansions: max_expansions, analyzer: analyzer } } }
    end
  end
end
