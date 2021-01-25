class ShopsController < ApplicationController
  def index
    @publisher_shops = PublisherShop
                           .includes(shop: {shop_books: :book})
                           .where(publisher_shops: {publisher_id: publisher_id}, books: {publisher_id: publisher_id})
                           .where('shop_books.copies_in_stock > 0')
                           .order('publisher_shops.books_sold_count DESC, shop_books.copies_in_stock DESC')
  end

  private

  def publisher
    Publisher.select(:id).find params[:publisher_id]
  end
end
