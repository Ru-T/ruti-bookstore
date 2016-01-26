class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.date :published_date
      t.string :author
      t.integer :price
      t.string :category
      t.text :description

      t.timestamps null: false
    end
  end
end
