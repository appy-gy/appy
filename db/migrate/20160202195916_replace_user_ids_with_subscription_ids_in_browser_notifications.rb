class MigrationUser < ActiveRecord::Base
  self.table_name = 'users'
end

class MigrationBrowserNotification < ActiveRecord::Base
  self.table_name = 'browser_notifications'
end

class MigrationBrowserNotificationSubscription < ActiveRecord::Base
  self.table_name = 'browser_notification_subscriptions'
end

class ReplaceUserIdsWithSubscriptionIdsInBrowserNotifications < ActiveRecord::Migration
  def up
    add_column :browser_notifications, :subscription_ids, :uuid, array: true, null: false, default: []
    add_index :browser_notifications, :subscription_ids, using: 'gin'

    MigrationBrowserNotification.find_each do |notification|
      users = MigrationUser.where id: notification.user_ids
      subscriptions = MigrationBrowserNotificationSubscription.where user_id: users.pluck(:id)
      notification.update subscription_ids: subscriptions.pluck(:id)
    end

    remove_column :browser_notifications, :user_ids
  end

  def down
    add_column :browser_notifications, :user_ids, :uuid, array: true, null: false, default: []
    add_index :browser_notifications, :user_ids, using: 'gin'

    MigrationBrowserNotification.find_each do |notification|
      subscriptions = MigrationBrowserNotificationSubscription.where(id: notification.subscription_ids).where.not(user_id: nil)
      notification.update user_ids: subscriptions.pluck(:user_id)
    end

    remove_column :browser_notifications, :subscription_ids
  end
end
