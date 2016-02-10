ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Recent Books" do
          ul do
            Book.last(10).map do |book|
              li link_to(book.title, admin_book_path(book))
            end
          end
        end
      end

      column do
        panel "Recent Orders" do
          ul do
            Order.last(10).map do |order|
              li link_to(order.user.email, admin_order_path(order))
            end
          end
        end
      end
    end
  end
end
