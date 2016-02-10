ActiveAdmin.register Book do

  index do
    column :title
    column :author
    column :published_date
    column :price_cents
    column :discount_cents
    column :category
    column :description
    actions
  end

  permit_params :title, :author, :published_date, :price_cents, :category, :description, :discount_cents
end
