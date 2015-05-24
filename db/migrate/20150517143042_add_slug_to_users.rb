class AddSlugToUsers < ActiveRecord::Migration
  def up
    add_column :users, :slug, :text
    User.find_each do |user|
      user.send :set_slug
      user.save
    end
    change_column_null :users, :slug, false
    add_index :users, :slug, unique: true
  end

  def down
    remove_column :users, :slug
  end
end
