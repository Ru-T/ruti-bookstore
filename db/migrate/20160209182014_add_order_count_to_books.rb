class AddOrderCountToBooks < ActiveRecord::Migration
  def change
    add_column :books, :purchase_count, :integer
  end
end
