module BrowserNotifications
  class Sender
    const :chrome_key, "key=#{ENV['TOP_CHROME_PUSH_NOTIFICATION_KEY']}"
    const :chrome_endpoint, 'https://android.googleapis.com/gcm/send'
    const :chrome_headers, { 'Authorization' => chrome_key, 'Content-Type' => 'application/json' }

    attr_reader :item

    def initialize item
      @item = item
    end

    def send
      create_notifications_of item

      BrowserNotificationSubscription.find_in_batches(batch_size: 100) do |subscriptions|
        Array.wrap(subscriptions).group_by(&:browser).each do |browser, subscriptions|
          __send__ "send_to_#{browser}", subscriptions
        end
      end
    end

    private

    def create_notifications_of item
      BrowserNotificationSubscription.includes(:user).find_each do |subscription|
        notification = BrowserNotification.create user: subscription.user
        notification.update payload: item.browser_notification_payload
      end
    end

    def send_to_chrome subscriptions
      reg_ids = subscriptions.map { |subscription| subscription.info['endpoint'].split('/').last }
      body = { registration_ids: reg_ids }.to_json
      HTTParty.post chrome_endpoint, body: body, headers: chrome_headers
    end

    def send_to_firefox subscriptions
      subscriptions.each do |subscription|
        HTTParty.post subscription.info['endpoint']
      end
    end
  end
end
