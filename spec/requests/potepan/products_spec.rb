require 'rails_helper'

RSpec.describe "Potepan::ProductsController", type: :request do
  describe "GET /potepan/products/:id" do
    let(:taxon) { create(:taxon) }
    let(:product) { create(:product, taxons: [taxon]) }
    let(:related_products_list) { create_list(:product, 4, taxons: [taxon]) }
    let(:fifth_related_product) { create(:product, taxons: [taxon], price: "12.34") }
    let(:related_products) { [related_products_list, fifth_related_product] }

    before do
      related_products.flatten!
      related_products.all? { |related_product| related_product.images << create(:image) }
      get potepan_product_url(id: product.id)
    end

    example "HTTPのステータスコードが200であること" do
      expect(response).to have_http_status(:success)
    end

    example "@productとproductが一致すること" do
      expect(controller.instance_variable_get("@product")).to eq product
    end

    example "HTMLに関連商品が４つだけ含まれていること" do
      related_products[0..3].all? do |related_product|
        expect(response.body).to include related_product.name
        expect(response.body).to include related_product.display_price.to_s
        expect(response.body).to include "#{related_product.id}-img"
      end
      expect(response.body).not_to include related_products[4].name
      expect(response.body).not_to include related_products[4].display_price.to_s
      expect(response.body).not_to include "#{related_products[4].id}-img"
    end
  end
end
