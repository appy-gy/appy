class AddNotNullConstraintToSectionsInvertedColor < ActiveRecord::Migration
  def change
    change_column_null :sections, :inverted_color, false
  end
end
