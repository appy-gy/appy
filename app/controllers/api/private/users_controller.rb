module Api
  module Private
    class UsersController < BaseController
      find :user, only: [:show, :update]

      def show
        render json: @user #, serializer: UserForProfileSerializer
      end

      def create
        user = Users::Create.new(user_params).call
        auto_login user
        render json: user
      end

      def update
        return render nothing: true, status: 400 unless policy.edit?
        user = Users::Update.new(@user, user_params).call
        render json: user, serializer: UserForProfileSerializer
      end

      private

      def user_params
        params.require(:user).permit(:email, :password, :name, :avatar)
      end

      def policy
        @policy ||= UserPolicy.new current_user, user
      end
    end
  end
end
