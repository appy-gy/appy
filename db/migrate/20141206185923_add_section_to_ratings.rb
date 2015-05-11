class AddSectionToRatings < ActiveRecord::Migration
  def change
    add_belongs_to :ratings, :section, index: true, foreign_key: true
  end
end
