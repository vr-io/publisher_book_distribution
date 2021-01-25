class SellsController < ApplicationController
  def create
    ShopBook.call(ShopBook.find(shop_id: params[:shop_id], book_id: params[:book_id]))
    render json: {status: 200}
  end
end
