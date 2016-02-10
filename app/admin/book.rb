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

  show do
    attributes_table do
      row :id
      row :title
      row :published_date
      row :author
      row :category
      row :description
      row(:price) { |book| number_to_currency book.price }
      row(:discount) { |book| number_to_currency book.discount }
      row :order_count
    end
  end

  form do |f|
    f.inputs "Book Details" do
      input :title
      input :published_date
      input :author
      input(:price) { |book| number_to_currency book.price }
      input(:discount) { |book| number_to_currency book.discount }
      input :discount_type, as: :select, collection: ["dollar", "percent"], include_blank: false
      input :category
      input :description
      actions
    end
  end

  before_create do |book|
    book.discount = price * discount if :discount_type == "percent"
  end

  permit_params :title,
                :author,
                :published_date,
                :price,
                :category,
                :description,
                :discount
end
