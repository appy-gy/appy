module Api
  module Private
    class BrowserNotificationsController < BaseController
      find :browser_notification, only: [:click]

      before_action :find_subscription

      def index
        notification = BrowserNotification.for(@subscription).order(:created_at).last
        return render json: {} unless notification
        notification.fetcher_ids.add @subscription.id
        render json: notification
      end

      def click
        @browser_notification.clicker_ids.add @subscription.id
        render json: { success: true }
      end

      private

      def find_subscription
        @subscription = BrowserNotificationSubscription.find session[:browser_notification_subscription_id]
      end
    end
  end
end
