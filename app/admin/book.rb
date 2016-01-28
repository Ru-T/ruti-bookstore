ActiveAdmin.register Book do

  index do
    column :title
    column :author
    column :published_date
    column :price
    column :category
    column :description
    actions
  end

  permit_params :title, :author, :published_date, :price, :category, :description
end
