class AddSectionToRatings < ActiveRecord::Migration
  def change
    add_reference :ratings, :section, type: :uuid, null: false, index: true
    add_foreign_key :ratings, :sections
  end
end
