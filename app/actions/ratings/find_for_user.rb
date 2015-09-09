module Ratings
  class FindForUser
    attr_reader :current_user, :user, :page

    const :per_page, 12

    def initialize current_user, user, page
      @current_user = current_user
      @user = user
      @page = page
    end

    def call
      ratings = user.ratings.includes(:tags).order(created_at: :desc)
      ratings = ratings.published unless Users::CanSeeDrafts.new(current_user, user).call
      ratings.page(page).per(per_page)
    end
  end
end
