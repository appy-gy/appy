class SorceryExternal < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.text :provider, :uid, null: false

      t.timestamps null: false

      t.belongs_to :user, null: false

      t.index [:provider, :uid]
    end
    add_foreign_key :authentications, :users
  end
end
