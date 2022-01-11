require 'rails_helper'

RSpec.describe "Potepan::ProductsController", type: :request do
  describe "GET /potepan/products/:id" do
    let(:taxon) { create(:taxon) }
    let(:product) { create(:product, taxons: [taxon]) }

    before do
      get potepan_product_url(id: product.id)
    end

    example "HTTPのステータスコードが200であること" do
      expect(response).to have_http_status(:success)
    end

    example "@productとproductが一致すること" do
      expect(controller.instance_variable_get("@product")).to eq product
    end
  end
end
