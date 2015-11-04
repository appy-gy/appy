class AddInvertedColorToSections < ActiveRecord::Migration
  def up
    add_column :sections, :inverted_color, :text

    Section.find_each do |section|
      inverted_color = section.color.scan(/\h\h/).map{ |str| (255 - str.to_i(16)).to_s(16).rjust(2, '0') }.join.prepend('#')
      section.update inverted_color: inverted_color
    end

    change_column_null :sections, :inverted_color, null: false
  end

  def down
    remove_column :sections, :inverted_color
  end
end
