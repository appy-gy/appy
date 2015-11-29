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

      private

      def user_params
        params.require(:user).permit(:email, :password, :name, :avatar, :background)
      end
    end
  end
end
