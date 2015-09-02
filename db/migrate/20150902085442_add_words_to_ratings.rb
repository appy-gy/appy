class AddWordsToRatings < ActiveRecord::Migration
  def change
    add_column :ratings, :words, :text, array: true, default: []
  end
end
