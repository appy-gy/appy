class SorceryCore < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text :email,            :null => false
      t.text :crypted_password, :null => false
      t.text :salt,             :null => false

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
