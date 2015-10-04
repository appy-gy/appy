module Ratings
  class FindInTag
    attr_reader :tag, :page

    const :per_page, 15

    def initialize tag, page
      @tag = tag
      @page = page
    end

    def call
      tag.ratings.includes(:user, :section, :items, :comments, :likes).published.order(published_at: :desc).page(page).per(per_page)
    end
  end
end
