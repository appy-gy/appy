module Api
  module Private
    class SessionsController < BaseController
      def show
        render json: current_user, serializer: CurrentUserSerializer
      end

      def create
        user = login *params[:session].values_at(:email, :password), true
        return render_error unless user
        render json: user, serializer: CurrentUserSerializer
      end

      def destroy
        logout
        cookies.delete :top_logged_in
        render json: { success: true }
      end

      def check
        cookies[:remember_me_token] = params[:token]
        render json: { logged_in: logged_in? }
      end
    end
  end
end
