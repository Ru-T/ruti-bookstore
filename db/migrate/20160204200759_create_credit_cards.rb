class CreateCreditCards < ActiveRecord::Migration
  def change
    create_table :credit_cards do |t|
      t.integer :user_id
      t.integer :last_four_digits
      t.string :billing_address1
      t.string :billing_address2
      t.string :billing_city
      t.string :billing_state
      t.integer :billing_zip

      t.timestamps null: false
    end
  end
end
