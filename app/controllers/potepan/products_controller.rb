class Potepan::ProductsController < ApplicationController
  DISPLAY_LIMIT = 4

  def show
    @product = Spree::Product.find(params[:id])
    @related_products = @product.related_products(DISPLAY_LIMIT).includes(master: [:images, :default_price])
  end
end
