class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.timestamps null: false

      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :rating, null: false, foreign_key: true

      t.index [:rating_id, :user_id], unique: true
    end
  end
end
