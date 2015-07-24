class AddSlugToRatings < ActiveRecord::Migration
  def change
    add_column :ratings, :slug, :text, null: false
    add_index :ratings, :slug, unique: true
  end
end
