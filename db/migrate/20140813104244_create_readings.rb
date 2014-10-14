class CreateReadings < ActiveRecord::Migration
  def change
    create_table :readings do |t|
      t.integer  :user_id
      t.integer  :post_id

      t.timestamps
    end
    add_index :readings, :user_id
    add_index :readings, :post_id
    add_index :readings, [:user_id, :post_id], unique: true
  end
end
