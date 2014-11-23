class SorceryRememberMe < ActiveRecord::Migration
  def change
    add_column :users, :remember_me_token, :text
    add_column :users, :remember_me_token_expires_at, :datetime

    add_index :users, :remember_me_token
  end
end
