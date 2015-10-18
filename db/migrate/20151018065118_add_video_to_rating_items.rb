class AddVideoToRatingItems < ActiveRecord::Migration
  def change
    add_column :rating_items, :video, :json, null: false, default: {}
  end
end
