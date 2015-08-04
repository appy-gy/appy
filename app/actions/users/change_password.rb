module Users
  class ChangePassword
    attr_reader :user, :old_password, :new_password

    def initialize user, old_password, new_password
      @user = user
      @old_password = old_password
      @new_password = new_password
    end

    def call
      return false unless user.valid_password? old_password
      user.update password: new_password
    end
  end
end
