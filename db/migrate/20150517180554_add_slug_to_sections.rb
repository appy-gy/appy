class AddSlugToSections < ActiveRecord::Migration
  def up
    add_column :sections, :slug, :text
    Section.find_each do |section|
      section.send :set_slug
      section.save
    end
    change_column_null :sections, :slug, false
    add_index :sections, :slug, unique: true
  end

  def down
    remove_column :sections, :slug
  end
end
