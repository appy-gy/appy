module Comments
  class FindForUser
    attr_reader :user

    def initialize user
      @user = user
    end

    def call
      user.comments.includes(:rating)
    end
  end
end
