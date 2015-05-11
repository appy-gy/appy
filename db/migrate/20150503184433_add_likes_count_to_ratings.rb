class AddLikesCountToRatings < ActiveRecord::Migration
  def change
    add_column :ratings, :likes_count, :integer, null: false, default: 0
  end
end
