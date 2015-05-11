class AddCommentsCountToRatings < ActiveRecord::Migration
  def change
    add_column :ratings, :comments_count, :integer, null: false, default: 0
  end
end
