class AddStatusToRatings < ActiveRecord::Migration
  def change
    add_column :ratings, :status, :integer, null: false, default: Rating.statuses[:draft]
  end
end
