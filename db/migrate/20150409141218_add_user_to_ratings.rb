class AddUserToRatings < ActiveRecord::Migration
  def change
    add_belongs_to :ratings, :user, index: true
    add_foreign_key :ratings, :users
  end
end
