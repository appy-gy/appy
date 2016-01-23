module Api
  module Private
    class BrowserNotificationsController < BaseController
      def show
        notification = BrowserNotification.recent.of(current_user).last
        render json: notification
      end
    end
  end
end
