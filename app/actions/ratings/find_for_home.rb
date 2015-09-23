module Ratings
  class FindForHome
    attr_reader :page

    const :per_page, 18

    def initialize page
      @page = page
    end

    def call
      Rating.includes(:user, :section, :tags, :items).published.where.not(id: main_page_ratings).order(published_at: :desc).page(page).per(per_page)
    end

    private

    def main_page_ratings
      @main_page_ratings ||= MainPageRatings::Find.new.call.to_a
    end
  end
end
