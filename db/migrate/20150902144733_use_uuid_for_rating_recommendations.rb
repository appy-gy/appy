class UseUuidForRatingRecommendations < ActiveRecord::Migration
  def change
    remove_column :ratings, :recommendations, :text, array: true, default: []
    add_column :ratings, :recommendations, :uuid, array: true, default: []
  end
end
