class CreateRatingsTags < ActiveRecord::Migration
  def up
    create_table :ratings_tags do |t|
      t.belongs_to :rating, null: false, index: true, foreign_key: true
      t.belongs_to :tag, null: false, index: true, foreign_key: true
    end
  end

  def down
    drop_table :ratings_tags
  end
end
