class SorceryCore < ActiveRecord::Migration
  def change
    create_table :users, id: :uuid do |t|
      t.text :email,            null: false
      t.text :crypted_password, null: false
      t.text :salt,             null: false

      t.timestamps null: false

      t.index :email, unique: true
    end
  end
end
