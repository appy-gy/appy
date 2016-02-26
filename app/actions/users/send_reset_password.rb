module Users
  class SendResetPassword
    attr_reader :email

    def initialize email
      @email = email
    end

    def call
      user = User.find_by email: email
      return false unless user
      user.deliver_reset_password_instructions!
    end
  end
end
