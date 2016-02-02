class MigrationUser < ActiveRecord::Base
  self.table_name = 'users'
end

class MigrationBrowserNotification < ActiveRecord::Base
  self.table_name = 'browser_notifications'

  include Redis::Objects

  set :fetcher_ids
  set :clicker_ids
end

class MigrationBrowserNotificationSubscription < ActiveRecord::Base
  self.table_name = 'browser_notification_subscriptions'
end

class PortBrowserNotificationFetchersAndClickers < ActiveRecord::Migration
  def up
    MigrationBrowserNotification.find_each do |notification|
      fetchers = MigrationUser.where id: notification.fetcher_ids.get
      clickers = MigrationUser.where id: notification.clicker_ids.get

      fetcher_subscriptions = MigrationBrowserNotificationSubscription.where user_id: fetchers.pluck(:id)
      clicker_subscriptions = MigrationBrowserNotificationSubscription.where user_id: clickers.pluck(:id)

      notification.fetcher_ids.clear
      notification.clicker_ids.clear
      notification.fetcher_ids.add fetcher_subscriptions.pluck(:id)
      notification.clicker_ids.add clicker_subscriptions.pluck(:id)
    end
  end

  def down
    MigrationBrowserNotification.find_each do |notification|
      fetcher_subscriptions = MigrationBrowserNotificationSubscription.where id: notification.fetcher_ids.get
      clicker_subscriptions = MigrationBrowserNotificationSubscription.where id: notification.clicker_ids.get

      fetchers = MigrationUser.where id: fetchers.pluck(:user_id)
      clickers = MigrationUser.where id: clickers.pluck(:user_id)

      notification.fetcher_ids.clear
      notification.clicker_ids.clear
      notification.fetcher_ids.add fetchers.pluck(:id)
      notification.clicker_ids.add clickers.pluck(:id)
    end
  end
end
