class ChangeRatingsRecommendations < ActiveRecord::Migration
  def change
    remove_belongs_to :ratings, :rating, index: true, foreign_key: true
    add_column :ratings, :recommendations, :text, array: true, default: []
  end
end
