ActiveAdmin.register Book do

  index do
    column :title
    column :author
    column :published_date
    column(:price) { |book| number_to_currency book.price }
    column(:discount) { |book| number_to_currency book.discount }
    column :category
    column :description
    actions
  end

  permit_params :title,
                :author,
                :published_date,
                :price_cents,
                :category,
                :description,
                :discount_cents
end
