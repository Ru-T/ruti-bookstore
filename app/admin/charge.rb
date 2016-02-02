ActiveAdmin.register Stripe::Charge do
  index do
    column :customer
    column :amount
    column :description
    column :currency
    column :receipt_email
    actions
  end

  permit_params :customer, :amount, :description, :currency, :receipt_email
end
