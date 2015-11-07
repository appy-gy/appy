class AddImageWidthToRatingItems < ActiveRecord::Migration
  def change
    add_column :rating_items, :image_width, :integer
  end
end
