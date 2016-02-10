class AddOrderCountToBooks < ActiveRecord::Migration
  def change
    add_column :books, :order_count, :integer
  end
end
