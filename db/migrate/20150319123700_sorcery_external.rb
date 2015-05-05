class SorceryExternal < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.text :provider, :uid, null: false

      t.timestamps null: false

      t.belongs_to :user, null: false, foreign_key: true

      t.index [:provider, :uid]
    end
  end
end
