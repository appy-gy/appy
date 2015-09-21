class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.text :body, null: false
      t.text :slug, null: false

      t.timestamps null: false

      t.index :slug, unique: true
    end
  end
end
