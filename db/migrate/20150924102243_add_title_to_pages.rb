class AddTitleToPages < ActiveRecord::Migration
  def change
    add_column :pages, :title, :text, null: false
  end
end
