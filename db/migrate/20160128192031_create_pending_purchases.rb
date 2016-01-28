class CreatePendingPurchases < ActiveRecord::Migration
  def change
    create_table :pending_purchases do |t|
      t.integer :user_id
      t.integer :book_id
      t.integer :quantity
      t.integer :price_at_purchase

      t.timestamps null: false
    end
    add_index :pending_purchases, :user_id
    add_index :pending_purchases, :book_id
  end
end
