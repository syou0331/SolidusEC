class Potepan::ProductsController < ApplicationController
  MAX_PRODUCT_DISPLAY_COUNT = 4

  def show
    @product = Spree::Product.find(params[:id])
    @related_products = @product.related_products.includes(master: [:images, :default_price]).limit(MAX_PRODUCT_DISPLAY_COUNT)
  end
end
