class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.integer :position, null: false
      t.integer :rating, null: false, default: 0
      t.text :title
      t.text :description
      t.text :image

      t.timestamps null: false

      t.belongs_to :rating, null: false, index: true, foreign_key: true
    end
  end
end
