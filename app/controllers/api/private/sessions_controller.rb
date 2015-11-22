module Api
  module Private
    class SessionsController < BaseController
      def create
        user = login *params[:session].values_at(:email, :password), true
        return render_error unless user
        render json: user, serializer: UserSerializer
      end

      def destroy
        logout
        cookies.delete :top_logged_in
        render json: { success: true }
      end
    end
  end
end
