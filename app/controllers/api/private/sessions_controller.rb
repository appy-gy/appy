module Api
  module Private
    class SessionsController < BaseController
      def show
        render json: current_user
      end

      def create
        user = login *params[:session].values_at(:email, :password), true
        return render_error unless user
        cookies[:top_logged_in] = { value: '1', expires: 10.years.from_now }
        render json: user
      end

      def destroy
        logout
        cookies.delete :top_logged_in
        render json: { success: true }
      end
    end
  end
end
