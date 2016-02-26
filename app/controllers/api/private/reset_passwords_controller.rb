module Api
  module Private
    class ResetPasswordsController < BaseController
      def create
        success = ::Users::SendResetPassword.new(params[:email]).call
        return render_error unless success
        render json: { success: true }
      end

      def update
        user = ::Users::ResetPassword.new(params[:token], params[:password]).call
        return render_error unless user
        auto_login user, true
        render json: user, serializer: CurrentUserSerializer
      end
    end
  end
end
