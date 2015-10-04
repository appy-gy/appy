class AddSlugToTags < ActiveRecord::Migration
  def change
    add_column :tags, :slug, :text
    add_index :tags, :slug, unique: true

    Tag.find_each(&:save)
  end
end
