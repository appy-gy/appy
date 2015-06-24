module Ratings
  class FindForHome
    attr_reader :page

    const :per_page, 18

    def initialize page
      @page = page
    end

    def call
      Rating.includes(:user, :section, :tags, :items).published.order(published_at: :desc).page(page).per(per_page)
    end
  end
end
