class AddStatusToRatings < ActiveRecord::Migration
  def change
    add_column :ratings, :status, :integer, default: Rating.statuses[:draft]
  end
end
