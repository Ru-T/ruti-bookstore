class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # , :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :line_items
  has_one :cart

  def add_to_cart(book)
    cart.line_items.create!(
      book_id: book.id,
      active: true,
      quantity: 1
    )
  end

  def remove_from_cart(book)
    cart.line_items.find_by_book_id(book.id).destroy
  end

  def in_cart?(book)
    cart.line_items.any? { |line_item| line_item[:book_id] == book.id }
  end
end
