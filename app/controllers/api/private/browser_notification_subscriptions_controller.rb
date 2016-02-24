module Api
  module Private
    class BrowserNotificationSubscriptionsController < BaseController
      def update
        subscription = ::BrowserNotificationSubscriptions::CreateOrUpdate.new(current_user, subscription_params).call
        cookies[:browser_notification_subscription_id] = { value: subscription.id, expires: 10.years.from_now, httponly: true }
        render json: { success: true }
      end

      private

      def subscription_params
        params.require(:subscription).permit(:browser, :endpoint)
      end
    end
  end
end
