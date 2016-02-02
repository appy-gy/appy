module Api
  module Private
    class BrowserNotificationSubscriptionsController < BaseController
      def update
        subscription = ::BrowserNotificationSubscriptions::CreateOrUpdate.new(current_user, subscription_params).call
        session[:browser_notification_subscription_id] = subscription.id
        render json: { success: true }
      end

      private

      def subscription_params
        params.require(:subscription).permit(:browser, :endpoint)
      end
    end
  end
end
