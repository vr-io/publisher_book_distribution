class SellsController < ApplicationController
  def create
    SellShopBook.call(
        ShopBook.find_by!(shop_id: params[:shop_id], book_id: params[:book_id]),
        amount
    )
    render json: {status: 200}
  end

end
