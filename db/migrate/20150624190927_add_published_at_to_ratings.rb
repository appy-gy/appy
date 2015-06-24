class AddPublishedAtToRatings < ActiveRecord::Migration
  def change
    add_column :ratings, :published_at, :datetime
  end
end
