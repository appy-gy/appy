class CreateRatingsTags < ActiveRecord::Migration
  def up
    create_table :ratings_tags, id: false do |t|
      t.references :rating, type: :uuid, null: false, index: true
      t.references :tag, type: :uuid, null: false, index: true
    end
    add_foreign_key :ratings_tags, :ratings
    add_foreign_key :ratings_tags, :tags
  end

  def down
    drop_table :ratings_tags
  end
end
