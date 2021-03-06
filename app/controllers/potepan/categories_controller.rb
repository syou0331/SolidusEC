class Potepan::CategoriesController < ApplicationController
  def show
    @taxon = Spree::Taxon.find(params[:id])
    @taxonomies = Spree::Taxon.roots
    @products = @taxon.all_products.includes(master: [:default_price, :images])
  end
end
