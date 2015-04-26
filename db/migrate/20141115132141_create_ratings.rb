class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings, id: :uuid do |t|
      t.text :title

      t.timestamps null: false
    end
  end
end
