class CreateRatingItems < ActiveRecord::Migration
  def change
    create_table :rating_items, id: :uuid do |t|
      t.integer :position, null: false
      t.integer :rating, null: false, default: 0
      t.text :title
      t.text :description
      t.text :image

      t.timestamps null: false

      t.belongs_to :rating, type: :uuid, null: false
    end
  end
end
