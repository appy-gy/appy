class RenameOptionsToRatingItems < ActiveRecord::Migration
  def change
    rename_table :options, :rating_items
  end
end
