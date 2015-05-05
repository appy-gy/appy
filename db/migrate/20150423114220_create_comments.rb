class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body, null: false

      t.timestamps null: false

      t.belongs_to :user, index: true, null: false, foreign_key: true
      t.belongs_to :rating, index: true, null: false, foreign_key: true
      t.uuid :parent_id
      t.foreign_key :comments, column: :parent_id
    end
  end
end
