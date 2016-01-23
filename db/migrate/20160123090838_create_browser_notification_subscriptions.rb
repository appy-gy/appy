class CreateBrowserNotificationSubscriptions < ActiveRecord::Migration
  def change
    create_table :browser_notification_subscriptions do |t|
      t.integer :browser, null: false
      t.json :info, null: false, default: {}
      t.timestamps null: false
      t.references :user, index: { unique: true }, null: false
    end
    add_foreign_key :browser_notification_subscriptions, :users
  end
end
