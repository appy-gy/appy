class CreateClientErrors < ActiveRecord::Migration
  def change
    create_table :client_errors do |t|
      t.json :info, null: false, default: {}
      t.timestamps null: false
    end
  end
end
