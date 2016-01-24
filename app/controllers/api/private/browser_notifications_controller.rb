module Api
  module Private
    class BrowserNotificationsController < BaseController
      def show
        notification = BrowserNotification.recent.of(User.find('api')).last
        render json: notification, serializer: BrowserNotificationSerializer
      end
    end
  end
end
