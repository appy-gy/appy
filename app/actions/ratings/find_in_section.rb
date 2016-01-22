module Ratings
  class FindInSection
    attr_reader :section, :page

    const :per_page, 15

    def initialize section, page
      @section = section
      @page = page
    end

    def call
      section.ratings.includes(:user, :section, :tags, :items).published.order(published_at: :desc).page(page).per(per_page)
    end
  end
end
