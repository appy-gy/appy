class AddSourceToRatings < ActiveRecord::Migration
  def change
    add_column :ratings, :source, :text
  end
end
