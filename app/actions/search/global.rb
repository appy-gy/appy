module Search
  class Global
    attr_reader :page

    const :slop, 20
    const :max_expansions, 10
    const :per_page, 10

    def initialize query, page
      @query = query
      @page = page
    end

    def call
      users = User.where('LOWER(name) LIKE ?', "%#{query}%").page(page).per(per_page).to_a
      ratings = Rating.where('LOWER(title) LIKE ?', "%#{query}%").page(page).per(per_page).to_a
      (users + ratings).sort_by(&:created_at).reverse
    end

    private

    def query
      @query.mb_chars.downcase.to_s
    end
  end
end
