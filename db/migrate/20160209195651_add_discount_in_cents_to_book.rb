class AddDiscountInCentsToBook < ActiveRecord::Migration
  def change
    add_column :books, :discount_cents, :integer
  end
end
