class MigrationBrowserNotification < ActiveRecord::Base
  self.table_name = 'browser_notifications'
end

class MultiuserBrowserNotifications < ActiveRecord::Migration
  def up
    add_column :browser_notifications, :user_ids, :uuid, array: true, null: false, default: []
    add_index :browser_notifications, :user_ids, using: 'gin'

    groups = MigrationBrowserNotification.all.group_by(&:payload)
    MigrationBrowserNotification.delete_all

    remove_column :browser_notifications, :user_id

    groups.each do |payload, notifications|
      user_ids = notifications.map(&:user_id)
      created_at = notifications.first.created_at
      MigrationBrowserNotification.create payload: payload, user_ids: user_ids, created_at: created_at
    end
  end

  def down
    add_reference :browser_notifications, :user, index: true
    add_foreign_key :browser_notifications, :users

    notifications = MigrationBrowserNotification.all.to_a
    MigrationBrowserNotification.delete_all
    notifications.each do |notification|
      notification.user_ids.each do |user_id|
        MigrationBrowserNotification.create payload: notification.payload, user_id: user_id, created_at: notification.created_at
      end
    end

    change_column_null :browser_notifications, :user_id, false
    remove_column :browser_notifications, :user_ids
  end
end
