class AddUserToRatings < ActiveRecord::Migration
  def change
    add_belongs_to :ratings, :user, type: :uuid
  end
end
