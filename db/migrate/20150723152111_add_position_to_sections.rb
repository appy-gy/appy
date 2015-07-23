class AddPositionToSections < ActiveRecord::Migration
  def change
    add_column :sections, :position, :integer, null: false, default: 0
  end
end
