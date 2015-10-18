class AddMetaToSections < ActiveRecord::Migration
  def change
    add_column :sections, :meta_title, :text
    add_column :sections, :meta_description, :text
    add_column :sections, :meta_keywords, :text
  end
end
