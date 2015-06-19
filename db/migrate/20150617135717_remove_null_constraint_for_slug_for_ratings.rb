class RemoveNullConstraintForSlugForRatings < ActiveRecord::Migration
  def change
    change_column_null :ratings, :slug, true
  end
end
