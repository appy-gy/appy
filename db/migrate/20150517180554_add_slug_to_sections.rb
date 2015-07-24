class AddSlugToSections < ActiveRecord::Migration
  def change
    add_column :sections, :slug, :text, null: false
    add_index :sections, :slug, unique: true
  end
end
