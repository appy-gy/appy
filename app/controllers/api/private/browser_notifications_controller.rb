module Api
  module Private
    class BrowserNotificationsController < BaseController
      def show
        notification = BrowserNotification.recent.of(current_user).order(:created_at).last
        render json: notification
      end
    end
  end
end
