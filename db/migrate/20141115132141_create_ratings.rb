class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings, id: :uuid do |t|
      t.text :title
      t.timestamps
    end
  end
end
