class AddDiscountInCentsToBook < ActiveRecord::Migration
  def change
    add_column :books, :discount_cents, :integer, default: 0
  end
end
