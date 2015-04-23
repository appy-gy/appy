class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments, id: :uuid do |t|
      t.text :body, null: false

      t.timestamps null: false

      t.belongs_to :user, type: :uuid, index: true, null: false
      t.belongs_to :rating, type: :uuid, index: true, null: false
      t.uuid :parent_id

      t.index :parent_id
    end
    add_foreign_key :comments, :users
    add_foreign_key :comments, :ratings
    add_foreign_key :comments, :comments, column: :parent_id
  end
end
