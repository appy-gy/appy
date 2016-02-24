module Api
  module Private
    class BrowserNotificationsController < BaseController
      find :browser_notification, only: [:click]

      before_action :find_subscription

      def index
        notifications = BrowserNotification.order(:created_at)
        notifications = notifications.for(@subscription) if @subscription
        notification = notifications.last
        return render json: {} unless notification
        notification.fetcher_ids.add @subscription.id if @subscription
        render json: notification
      end

      def click
        @browser_notification.clicker_ids.add @subscription.id if @subscription
        render json: { success: true }
      end

      private

      def find_subscription
        @subscription = BrowserNotificationSubscription.find cookies[:browser_notification_subscription_id]
      end
    end
  end
end
