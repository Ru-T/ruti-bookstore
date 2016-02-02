class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.integer :user_id
      t.integer :book_id
      t.integer :quantity
      t.boolean :active

      t.timestamps null: false
    end
  end
end
