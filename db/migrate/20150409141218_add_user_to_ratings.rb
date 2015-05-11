class AddUserToRatings < ActiveRecord::Migration
  def change
    add_belongs_to :ratings, :user, index: true, foreign_key: true
  end
end
