ActiveAdmin.register Order do
  index do
    column :user
    column (:total) { |order| number_to_currency order.total / 100 }
    column :shipping_city
    column :shipping_zip
    column "Line Items" do |order|
      table_for order.line_items do
        column :book
        column :quantity
        column(:price) { |line_item| number_to_currency line_item.book.price }
        column(:discount_price) { |line_item| number_to_currency line_item.book.discount_price }
        column (:total_price) { |order| number_to_currency order.total_price }
      end
    end
  end

  permit_params :user, :total, :shipping_address1, :shipping_address2, :shipping_city, :shipping_state, :shipping_zip
end
