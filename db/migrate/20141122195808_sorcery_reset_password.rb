class SorceryResetPassword < ActiveRecord::Migration
  def change
    add_column :users, :reset_password_token, :text
    add_column :users, :reset_password_token_expires_at, :datetime
    add_column :users, :reset_password_email_sent_at, :datetime

    add_index :users, :reset_password_token
  end
end
