module Api
  module Private
    class BrowserNotificationsController < BaseController
      find :browser_notification, only: [:click]

      def index
        notification = BrowserNotification.recent.for(current_user).order(:created_at).last
        return render json: {} unless notification
        notification.fetcher_ids.add current_user.id
        render json: notification
      end

      def click
        @browser_notification.clicker_ids.add current_user.id
        render json: { success: true }
      end
    end
  end
end
