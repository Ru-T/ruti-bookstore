class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # , :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :pending_purchases

  def add_to_cart(book)
    pending_purchases.create!(
      book_id: book.id,
      price_at_purchase: book.price,
      quantity: 1
    )
  end

  def remove_from_cart(book)
    pending_purchases.find_by_book_id(book.id).destroy
  end

  def in_cart?(book)
    pending_purchases.any? { |pending_purchase| pending_purchase[:book_id] == book.id }
  end
end
