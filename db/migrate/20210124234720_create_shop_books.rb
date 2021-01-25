class CreateShopBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :shop_books do |t|
      t.belongs_to :shop, foreign_key: true
      t.belongs_to :book, foreign_key: true
      t.integer :copies_in_stock, null: false, default: 0
      t.integer :copies_sold,     null: false, default: 0
      t.timestamps
    end
  end
end
