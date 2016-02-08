class AddShippingToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :shipping_address1, :string
    add_column :orders, :shipping_address2, :string
    add_column :orders, :shipping_city, :string
    add_column :orders, :shipping_state, :string
    add_column :orders, :shipping_zip, :integer
  end
end
