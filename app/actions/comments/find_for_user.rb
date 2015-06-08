module Comments
  class FindForUser
    attr_reader :user, :page

    const :per_page, 15

    def initialize user, page
      @user = user
      @page = page
    end

    def call
      user.comments.includes(:rating).page(page).per(per_page)
    end
  end
end
