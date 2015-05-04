module Api
  module Private
    class UsersController < BaseController
      find :user, only: [:show, :update]
      check 'Users::CanEdit', :@user, only: [:update]

      def show
        render json: @user, serializer: UserForProfileSerializer
      end

      def create
        user = ::Users::Create.new(user_params).call
        auto_login user
        render json: user
      end

      def update
        user = ::Users::Update.new(@user, user_params).call
        render json: user, serializer: UserForProfileSerializer
      end

      private

      def user_params
        params.require(:user).permit(:email, :password, :name, :avatar,
          :facebook_link, :instagram_link)
      end
    end
  end
end
