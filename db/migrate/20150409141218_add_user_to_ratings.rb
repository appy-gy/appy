class AddUserToRatings < ActiveRecord::Migration
  def change
    add_belongs_to :ratings, :user, type: :uuid, index: true
    add_foreign_key :ratings, :users
  end
end
