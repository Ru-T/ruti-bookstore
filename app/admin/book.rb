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
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
  permit_params :title, :author, :published_date, :price, :category, :description
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end


end
