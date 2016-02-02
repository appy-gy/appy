class MigrationBrowserNotificationSubscription < ActiveRecord::Base
  self.table_name = 'browser_notification_subscriptions'
end

class AddEndpointToBrowserNotificationSubscriptions < ActiveRecord::Migration
  def up
    add_column :browser_notification_subscriptions, :endpoint, :text

    MigrationBrowserNotificationSubscription.find_each do |subscription|
      subscription.update endpoint: subscription.info['endpoint']
    end

    change_column_null :browser_notification_subscriptions, :endpoint, false
    remove_column :browser_notification_subscriptions, :info
    add_index :browser_notification_subscriptions, [:endpoint, :browser], name: 'index_bns_on_endpoint_and_browser', unique: true
    remove_index :browser_notification_subscriptions, :user_id
  end

  def down
    add_column :browser_notification_subscriptions, :info, :json, null: false, default: {}

    MigrationBrowserNotificationSubscription.find_each do |subscription|
      subscription.update info: { endpoint: subscription.endpoint }
    end

    remove_index :browser_notification_subscriptions, name: 'index_bns_on_endpoint_and_browser'
    remove_column :browser_notification_subscriptions, :endpoint, :text
    add_index :browser_notification_subscriptions, :user_id, unique: true
  end
end
