class RemoveNotNullConstraintFromBrowserNotificationSubscriptionUserId < ActiveRecord::Migration
  def change
    change_column_null :browser_notification_subscriptions, :user_id, true
  end
end
