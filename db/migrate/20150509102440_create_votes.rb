class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :kind, null: false

      t.timestamps null: false

      t.references :user, null: false, index: true, foreign_key: true
      t.references :rating_item, null: false, index: true, foreign_key: true
    end
  end
end
