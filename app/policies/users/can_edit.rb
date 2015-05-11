module Users
  class CanEdit < BasePolicy
    arguments :user

    def call
      current_user == user
    end
  end
end
