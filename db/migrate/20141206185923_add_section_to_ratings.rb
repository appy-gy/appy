class AddSectionToRatings < ActiveRecord::Migration
  def change
    add_belongs_to :ratings, :section, index: true
    add_foreign_key :ratings, :sections
  end
end
