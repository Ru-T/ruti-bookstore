class AddPurchasedBoolean < ActiveRecord::Migration
  def change
    add_column :pending_purchases, :purchased, :boolean, default: false
  end
end
