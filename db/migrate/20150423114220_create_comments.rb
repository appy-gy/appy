class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body, null: false

      t.timestamps null: false

      t.belongs_to :user, index: true, null: false
      t.belongs_to :rating, index: true, null: false
      t.uuid :parent_id
    end
    add_foreign_key :comments, :users
    add_foreign_key :comments, :ratings
    add_foreign_key :comments, :comments, column: :parent_id
  end
end
