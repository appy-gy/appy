module Users
  class ResetPassword
    attr_reader :token, :password

    def initialize token, password
      @token = token
      @password = password
    end

    def call
      user = User.load_from_reset_password_token(token)
      return false unless user and user.change_password!(password)
      user
    end
  end
end
