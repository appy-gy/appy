module BrowserNotifications
  class Sender
    const :chrome_key, "key=#{ENV['TOP_CHROME_PUSH_NOTIFICATION_KEY']}"
    const :chrome_endpoint, 'https://android.googleapis.com/gcm/send'
    const :chrome_headers, { 'Authorization' => chrome_key, 'Content-Type' => 'application/json' }

    attr_reader :notification

    def initialize notification
      @notification = notification
    end

    def send
      notification.update subscription_ids: subscriptions.map(&:id)

      subscriptions.group_by(&:browser).each do |browser, subscriptions|
        __send__ "send_to_#{browser}", subscriptions
      end
    end

    def send_to user
      subscription = BrowserNotificationSubscription.find_by user: user
      return unless subscription
      __send__ "send_to_#{subscription.browser}", Array.wrap(subscription)
    end

    private

    def subscriptions
      @subscriptions ||= BrowserNotificationSubscription.all.to_a
    end

    def send_to_chrome subscriptions
      reg_ids = subscriptions.map { |subscription| subscription.endpoint.split('/').last }
      body = { registration_ids: reg_ids }.to_json
      HTTParty.post chrome_endpoint, body: body, headers: chrome_headers
    end

    def send_to_firefox subscriptions
      subscriptions.each do |subscription|
        HTTParty.post subscription.endpoint
      end
    end
  end
end
