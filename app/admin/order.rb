ActiveAdmin.register Order do
  index do
    column :user
    column :total
    column "Line Items" do |order|
      order.line_items.each do |line_item|
      end
    end
  end

  permit_params :user, :total
end
