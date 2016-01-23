module Api
  module Private
    class BrowserNotificationSubscriptionsController < BaseController
      def update
        result = ::BrowserNotificationSubscriptions::CreateOrUpdate.new(current_user, subscription_params).call
        render json: { success: true }
      end

      private

      def subscription_params
        params.require(:subscription).permit(:browser, info: [:endpoint])
      end
    end
  end
end
