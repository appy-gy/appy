class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.text :title

      t.timestamps null: false
    end
  end
end
