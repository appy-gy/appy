module Api
  module Private
    class UsersController < BaseController
      def create
        user = User.create user_params
        auto_login user
        render json: user
      end

      def update
      end

      private

      def user_params
        params.require(:user).permit(:email, :password)
      end
    end
  end
end
