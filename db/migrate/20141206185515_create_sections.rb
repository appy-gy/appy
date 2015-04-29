class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.text :name, null: false
      t.text :color, null: false

      t.timestamps null: false
    end
  end
end
