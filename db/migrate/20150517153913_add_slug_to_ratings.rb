class AddSlugToRatings < ActiveRecord::Migration
  def up
    add_column :ratings, :slug, :text
    Rating.find_each do |rating|
      rating.send :set_slug
      rating.save
    end
    change_column_null :ratings, :slug, false
    add_index :ratings, :slug, unique: true
  end

  def down
    remove_column :ratings, :slug
  end
end
