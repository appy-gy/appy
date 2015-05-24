class AddImageToRatings < ActiveRecord::Migration
  def change
    add_column :ratings, :image, :text
  end
end
