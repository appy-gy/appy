class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings, id: :uuid do |t|
      t.text :title, null: false

      t.timestamps null: false
    end
  end
end
