module Users
  class CanSeeDrafts < BasePolicy
    arguments :user

    def call
      current_user == user
    end
  end
end
