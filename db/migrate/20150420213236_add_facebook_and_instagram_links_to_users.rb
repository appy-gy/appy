class AddFacebookAndInstagramLinksToUsers < ActiveRecord::Migration
  def change
    add_column :users, :facebook_link, :text
    add_column :users, :instagram_link, :text
  end
end
