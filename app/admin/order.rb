ActiveAdmin.register Order do
  index do
    column :user
    column :total
    column "Line Items" do |order|
      table_for order.line_items do
        column :book
        column :quantity
        column(:price) { |line_item| number_to_currency line_item.book.price }
        column(:discount_price) { |line_item| number_to_currency line_item.book.discount_price }
        column (:total_price) { |order| number_to_currency order.total_price }
        column :shipping_city
        column :shipping_zip
      end
    end
  end

  permit_params :user, :total
end
