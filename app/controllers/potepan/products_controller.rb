class Potepan::ProductsController < ApplicationController
  MAX_DISPLAY_COUNT = 4 # 関連商品の最大表示数

  def show
    @product = Spree::Product.find(params[:id])
    @related_products = @product.related_products.includes(master: [:images, :default_price]).limit(MAX_DISPLAY_COUNT)
  end
end
