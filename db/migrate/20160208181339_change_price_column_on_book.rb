class ChangePriceColumnOnBook < ActiveRecord::Migration
  def change
    add_column :books, :price_cents, :integer
    remove_column :books, :price, :integer
  end
end
