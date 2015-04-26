class RemoveRememberMeTokenFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :remember_me_token, :text
    remove_column :users, :remember_me_token_expires_at, :datetime
  end
end
