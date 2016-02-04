ActiveAdmin.register Order do
  index do
    column :user
    column :total
    column "Line Items" do |order|
      table_for order.line_items do
        column :book
        column :quantity
        column(:price) { |line_item| line_item.book.price }
        column :total_price
      end
    end
  end

  permit_params :user, :total
end
