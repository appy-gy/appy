class AddNotNullConstraintToTagsSlug < ActiveRecord::Migration
  def change
    change_column_null :tags, :slug, false
  end
end
