class OrderMailer < ApplicationMailer
  default from: "receipt@bookstore.com"

  def receipt_email(user)
    @user = user
    @order = user.orders.last
    mail(to: @user.email, subject: "Your Order Has Been Completed")
  end
end
