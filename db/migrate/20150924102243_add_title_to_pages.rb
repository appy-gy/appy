class AddTitleToPages < ActiveRecord::Migration
  def up
    add_column :pages, :title, :text
    Page.find_each { |page| page.update title: 'temp' }
    change_column_null :pages, :title, false
  end

  def down
    remove_column :pages, :title
  end
end
