class AddRatingsCountToTags < ActiveRecord::Migration
  def change
    add_column :tags, :ratings_count, :integer, null: false, default: 0
  end
end
