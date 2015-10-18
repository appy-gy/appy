class AddNotNullConstaintToSectionsMeta < ActiveRecord::Migration
  def change
    Section.find_each do |section|
      %i{meta_title meta_description meta_keywords}
        .reject { |field| section.public_send "#{field}?" }
        .each { |field| section.public_send "#{field}=", section.name }
      section.save
    end

    change_column_null :sections, :meta_title, false
    change_column_null :sections, :meta_description, false
    change_column_null :sections, :meta_keywords, false
  end

  def down
    change_column_null :sections, :meta_title, true
    change_column_null :sections, :meta_description, true
    change_column_null :sections, :meta_keywords, true
  end
end
