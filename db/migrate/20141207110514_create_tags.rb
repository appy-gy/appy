class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags, id: :uuid do |t|
      t.text :name, null: false

      t.timestamps null: false
    end
  end
end
