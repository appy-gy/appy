class AddDescriptionToRatings < ActiveRecord::Migration
  def change
    add_column :ratings, :description, :text
  end
end
