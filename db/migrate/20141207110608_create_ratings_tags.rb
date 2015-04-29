class CreateRatingsTags < ActiveRecord::Migration
  def up
    create_table :ratings_tags do |t|
      t.belongs_to :rating, null: false, index: true
      t.belongs_to :tag, null: false, index: true
    end
    add_foreign_key :ratings_tags, :ratings
    add_foreign_key :ratings_tags, :tags
  end

  def down
    drop_table :ratings_tags
  end
end
