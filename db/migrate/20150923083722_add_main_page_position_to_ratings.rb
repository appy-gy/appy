class AddMainPagePositionToRatings < ActiveRecord::Migration
  def change
    add_column :ratings, :main_page_position, :integer
    add_index :ratings, :main_page_position, unique: true
  end
end
