class ShopBook < ApplicationRecord
  belongs_to :shop
  belongs_to :book

  after_commit :update_publisher_shop, on: %i[create update destroy]

  def update_publisher_shop
    PublisherShop.find_or_create_by(publisher: book.publisher, shop: shop).update_books_sold_count
  end

  def call(shop_book)
    ShopBook.unscoped
        .where(ShopBook.primary_key => shop_book.id)
        .update_all(['copies_sold = copies_sold + :amount, copies_in_stock = copies_in_stock - :amount',])
    shop_book.touch
  end
end
