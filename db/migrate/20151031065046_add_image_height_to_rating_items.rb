class AddImageHeightToRatingItems < ActiveRecord::Migration
  def change
    add_column :rating_items, :image_height, :integer
  end
end
