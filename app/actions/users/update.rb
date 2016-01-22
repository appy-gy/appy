module Users
  class Update
    attr_reader :user, :params

    def initialize user, params
      @user = user
      @params = params
    end

    def call
      user.update params
      user
    end
  end
end
