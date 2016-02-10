ActiveAdmin.register Book do

  index do
    column :title
    column :author
    column :published_date
    column :price do |book|
      div :class => "price" do
        number_to_currency book.price
      end
    end
    column :discount do |book|
      div :class => "discount" do
        number_to_currency book.discount
      end
    end
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
