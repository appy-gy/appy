class CreateBrowserNotifications < ActiveRecord::Migration
  def change
    create_table :browser_notifications do |t|
      t.json :payload, null: false, default: {}
      t.timestamps null: false
      t.references :user, index: true, null: false
    end
    add_foreign_key :browser_notifications, :users
  end
end
