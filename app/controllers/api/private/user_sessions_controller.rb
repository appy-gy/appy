module Api
  module Private
    class UserSessionsController < BaseController
      def create
        @user = login *params[:user_session].values_at(:email, :password, :remember)
        render json: @user
      end

      def destroy
        logout
        render json: { success: true }
      end
    end
  end
end
