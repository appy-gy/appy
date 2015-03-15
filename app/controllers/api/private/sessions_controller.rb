module Api
  module Private
    class SessionsController < BaseController
      def show
        render json: current_user
      end

      def create
        user = login *params[:session].values_at(:email, :password, :remember)
        render json: user
      end

      def destroy
        logout
        render json: { success: true }
      end
    end
  end
end