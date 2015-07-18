class AddSlugToUsers < ActiveRecord::Migration
  def change
    add_column :users, :slug, :text, null: false
    add_index :users, :slug, unique: true
  end
end
