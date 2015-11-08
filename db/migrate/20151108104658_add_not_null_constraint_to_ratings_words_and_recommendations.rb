class AddNotNullConstraintToRatingsWordsAndRecommendations < ActiveRecord::Migration
  def change
    change_column_null :ratings, :words, false
    change_column_null :ratings, :recommendations, false
  end
end
