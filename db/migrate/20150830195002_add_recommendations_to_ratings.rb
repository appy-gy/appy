class AddRecommendationsToRatings < ActiveRecord::Migration
  def change
    add_belongs_to :ratings, :rating, index: true, foreign_key: true
  end
end
