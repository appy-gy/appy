module Api
  module Private
    class ResetPasswordsController < BaseController
      def create
        success = ::Users::ResetPassword.new(params[:email]).call
        return render_error unless success
        render json: { success: true }
      end
    end
  end
end
