class Potepan::ProductsController < ApplicationController
  DISPLAY_LIMIT = 4 # 関連商品の最大表示数

  def show
    @product = Spree::Product.find(params[:id])
    @related_products = @product.related_products(DISPLAY_LIMIT).includes(master: [:images, :default_price])
  end
end
