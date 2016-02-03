class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # , :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :line_items
  has_many :orders
  has_one  :cart

  after_save :create_cart
  after_save :create_order

  def create_cart
    Cart.create!(user: self)
  end

  def create_order
    Order.create!(user: self)
  end

  def remove_from_cart(book)
    line_items.find_by_book_id(book.id).destroy
  end

  def in_cart?(book)
    line_items.any? { |line_item| line_item[:book_id] == book.id }
  end
end
