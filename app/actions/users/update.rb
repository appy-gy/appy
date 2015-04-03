module Users
  class Update
    attr_reader :user, :params

    def initialize user, params
      @user, @params = user, params
    end

    def call
      user.update params
      user
    end
  end
end
