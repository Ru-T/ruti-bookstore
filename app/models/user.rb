class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # , :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :pending_purchases

  def pending_purchase(book)
    pending_purchases.create!(book_id: book.id,
                              price_at_purchase: book.price,
                              quantity: 1
                              )
  end
end
