class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # , :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :cart
  has_many :orders
  has_one :credit_card

  after_create :create_cart

  def create_cart
    Cart.create(user: self)
  end
end
