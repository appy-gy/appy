module Api
  module Private
    class UsersController < BaseController
      def show
        user = User.find params[:id]
        render json: user
      end

      def create
        user = User.create user_params
        auto_login user
        render json: user
      end

      def update
        user = Users::Update.new.call user, user_params
        render json: user
      end

      private

      def user_params
        params.require(:user).permit(:email, :password, :avatar)
      end
    end
  end
end
