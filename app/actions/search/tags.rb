module Search
  class Tags
    attr_reader :query

    def initialize query
      @query = query
    end

    def call
      Tag.where('LOWER(name) LIKE ?', "%#{query}%").limit(10)
    end

    private

    def query
      @query.mb_chars.downcase.to_s
    end
  end
end
