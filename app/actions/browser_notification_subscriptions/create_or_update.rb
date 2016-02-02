module BrowserNotificationSubscriptions
  class CreateOrUpdate
    attr_reader :user, :params

    def initialize user, params
      @user = user
      @params = params
    end

    def call
      subscription = BrowserNotificationSubscription.find_or_initialize_by params
      subscription.user = user if user
      subscription.save
      subscription
    end
  end
end
