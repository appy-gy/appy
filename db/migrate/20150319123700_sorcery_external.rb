class SorceryExternal < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.integer :user_id, null: false
      t.text :provider, :uid, null: false

      t.timestamps null: false

      t.index [:provider, :uid]
    end
  end
end
