class RenameRatingItemsRating < ActiveRecord::Migration
  def change
    rename_column :rating_items, :rating, :mark
  end
end
