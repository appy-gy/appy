class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.belongs_to :rating
      t.integer :position, default: 0
      t.integer :rating, default: 0
      t.text :title
      t.text :description
      t.text :image
      t.timestamps
    end
  end
end
