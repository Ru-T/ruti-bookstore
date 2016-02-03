ActiveAdmin.register Order do

  index do
    column :user
    column :total
  end

  permit_params :user, :total
end
