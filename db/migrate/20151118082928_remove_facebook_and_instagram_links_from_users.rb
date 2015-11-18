class RemoveFacebookAndInstagramLinksFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :facebook_link, :text
    remove_column :users, :instagram_link, :text
  end
end
