module Api
  module Private
    class UsersController < BaseController
      find :user, only: [:update, :change_password]
      check 'Users::CanEdit', :@user, only: [:update, :change_password]

      def create
        user = ::Users::Create.new(user_params).call
        return render_error user.errors unless user.persisted?
        auto_login user
        render json: user
      end

      def update
        user = ::Users::Update.new(@user, user_params).call
        render json: user, serializer: UserForProfileSerializer
      end

      def change_password
        success = ::Users::ChangePassword.new(@user, *params.values_at(:old_password, :new_password)).call
        return render_error unless success
        render json: { success: true }
      end

      private

      def user_params
        params.require(:user).permit(:email, :password, :name, :avatar,
          :background, :facebook_link, :instagram_link)
      end
    end
  end
end
